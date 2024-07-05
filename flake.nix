{
  description = "nixos configuration with flakes and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    hyprcursor-phinger.url = "github:Jappie3/hyprcursor-phinger";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      disko,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      pkgs-conf = {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs pkgs-conf;
      pkgs-unstable = import nixpkgs-unstable pkgs-conf;
    in
    {
      formatter = nixpkgs.legacyPackages."x86_64-linux".nixfmt-rfc-style;

      nixosConfigurations = {
        bellion = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              outputs
              pkgs
              pkgs-unstable
              ;
          };
          modules = [
            ./hosts/bellion

            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.bane = import ./home/bane;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs outputs pkgs-unstable;
              };
            }
          ];
        };
      };
    };
}
