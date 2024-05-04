{
  description = "Home Manager configuration of bane";

  # takes urls for pkgs and inputs, imports, pkgs repos etc..
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  # tells what to do with pkgs/urls/inputs in input block
  outputs = { nixpkgs, home-manager, ... }:
    let

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {

      homeConfigurations."bane" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
