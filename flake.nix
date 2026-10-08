{
  description = "Modular NixOS configuration using flakes and home-manger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs?ref=nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
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
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    #---- Additional flake inputs -----#
    nix-neovim.url = "github:baneetparmar/nix-neovim";
    nix-neovim.inputs.nixpkgs.follows = "nixpkgs";
    wallpapers.url = "github:baneetparmar/walls-n-windows";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.51.0";
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow";
      inputs.hyprland.follows = "hyprland";
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

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
      ];

      globals = {
        username = "baneetparmar";
        stateVersion = "25.05";
      };
      # use namespace to avoid collisions
      namespace = "custom";

      customLib = nixpkgs.lib.extend (
        self: super: { "${namespace}" = import ./lib { inherit (nixpkgs) lib; }; }
      );

      # x86_64-darwin needs pkgs from nixpkgs-darwin (nixpkgs 26.11 dropped
      # the platform) - everything else stays on the main nixpkgs input.
      pkgsFor =
        system:
        (if lib.hasSuffix "-darwin" system then inputs.nixpkgs-darwin else nixpkgs)
        .legacyPackages.${system};

      # os folder name -> builder. "if it's linux, build linux; if it's
      # darwin, build darwin" - this table is the only OS-specific part left.
      builders = {
        linux = lib.nixosSystem;
        darwin = inputs.nix-darwin.lib.darwinSystem;
      };

      # every host under ./hosts/<arch>/<os>/<hostname>, arch/os/system deciphered
      # automatically from the path by lib.custom.discoverHosts
      discoveredHosts = customLib.${namespace}.discoverHosts ./hosts;

      # one function builds either kind of system - dispatch happens via
      # lib.custom.selectBuilder, keyed off each discovered host's `os`
      mkHost =
        {
          os,
          hostname,
          path,
          system,
          ...
        }:
        {
          ${hostname} = (customLib.${namespace}.selectBuilder builders os) {
            inherit system;
            specialArgs = {
              inherit
                inputs
                outputs
                globals
                namespace
                system
                ;
              lib = customLib;
            };
            modules = [ path ];
          };
        };

      mkHostConfigs =
        os:
        lib.foldl (acc: set: acc // set) { } (
          lib.map mkHost (builtins.filter (h: h.os == os) discoveredHosts)
        );

      # required for treefmt-nix
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f (pkgsFor system));
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {

      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = mkHostConfigs "linux";
      darwinConfigurations = mkHostConfigs "darwin";

      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        import ./packages { inherit pkgs; }
      );

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      devShells = forAllSystems (
        system:
        import ./shell.nix {
          pkgs = pkgsFor system;
        }
      );
    };

}
