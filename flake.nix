{
  description = "Modular NixOS configuration using flakes and home-manger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    #---- Additional flakes -----#
    nix-neovim.url = "github:baneetparmar/nix-neovim";
    hyprpanel = {
      url = "github:Jas-SinghFSU/Hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      treefmt-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      # make Host configs.
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];

      globals = {
        username = "shadow";
        stateVersion = "24.11";
      };
      # use namespace to avoid collisions with default names
      namespace = "custom";
      mkHost = host: {
        ${host} =
          let
            func = lib.nixosSystem;
            systemFunc = func;
          in
          systemFunc {
            specialArgs = {
              inherit
                inputs
                outputs
                globals
                namespace
                ;

              lib = nixpkgs.lib.extend (
                self: super: { "${namespace}" = import ./lib { inherit (nixpkgs) lib; }; }
              );

            };
            modules = [ ./hosts/${host} ];
          };
      };
      mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) { } (lib.map (host: mkHost host) hosts);
      readHosts = lib.attrNames (builtins.readDir ./hosts);

      # required for treefmt-nix
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {

      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = mkHostConfigs (readHosts);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./packages { inherit pkgs; }
      );

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      devShells = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );
    };

}
