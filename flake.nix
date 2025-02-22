{
  description = "NixOS configuration using flakes and home-manger";

  inputs = {
    # channels
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    legacy.url = "github:nixos/nixpkgs?ref=nixos-24.05";

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
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-frost = {
      url = "github:snowfallorg/frost";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:baneetparmar/ags/ags-rewrite";
    stylix.url = "github:danth/stylix?ref=release-24.11";
    nixvim.url = "github:baneetparmar/nixvim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.hyprland.follows = "nixpkgs";
    };
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";
    hypr-chroma.url = "github:alexhulbert/hyprchroma";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "snow";
          meta = {
            name = "baneetparmar";
            title = "nixfiles";
          };
        };
      };

    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [ ];
      };

      overlays = with inputs; [
        snowfall-frost.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        chaotic.nixosModules.default
        home-manager.nixosModules.home-manager
      ];

      # Add WSL modules to host
      systems.hosts.jima.modules = with inputs; [
        nixos-wsl.nixosModules.default
      ];

      homes.modules = with inputs; [
      ];

      outputs-builder =
        channels:
        let
          treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
        in
        {
          formatter = treefmtEval.config.build.wrapper;
          checks = {
            treefmt = treefmtEval.config.build.check inputs.self;
          };
          devShells = import ./shell.nix { };
        };
    };
}
