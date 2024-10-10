{
  description = "NixOS configuration using flakes and home-manger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.05";
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
    treefmt-nix.url = "github:numtide/treefmt-nix";

    ags.url = "github:Aylur/ags";
    ignis.url = "github:linkfrg/ignis";
    nixvim.url = "github:baneetparmar/nixvim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";
    ags-config.url = "github:JayRovacsek/ags-config";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    {
      self,
      disko,
      nixpkgs,
      home-manager,
      treefmt-nix,
      systems,
      ...
    }@inputs:
    let
      username = "shadow";
      host = "bellion";

      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      # required for treefmt-nix 
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      inherit (nixpkgs) lib;
      specialArgs = {
        inherit
          inputs
          outputs
          nixpkgs
          username
          host
          ;
      };
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper); # set treefmt as default formatter

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      nixosConfigurations = {
        ${host} = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./hosts/${host}
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.users.${username} = import ./home/${username}/${host}.nix;
              home-manager.extraSpecialArgs = specialArgs;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "old";
            }
          ];
        };
      };
    };
}
