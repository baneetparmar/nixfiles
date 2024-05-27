{
  description = "Home Manager configuration of bane";

  # takes urls for pkgs and inputs, imports, pkgs repos etc..
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    stylix.url = "github:danth/stylix/release-23.11";
    matugen.url = "github:InioX/Matugen";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";
  };

  # tells what to do with pkgs/urls/inputs in input block
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, matugen, spicetify-nix
    , hyprcursor-phinger, ags, stylix, ... }@inputs:
    let

      pkgs-common-configs = {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs = import nixpkgs pkgs-common-configs;
      pkgs-unstable = import nixpkgs-unstable pkgs-common-configs;
    in {

      homeConfigurations."bane" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix 
        ];

        extraSpecialArgs = {
          inherit ags;
          inherit stylix;
          inherit matugen;
          inherit pkgs-unstable;
          inherit spicetify-nix;
          inherit hyprcursor-phinger;
        };
      };
    };
}
