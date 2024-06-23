{
  nixpkgs,
  nixpkgs-unstable,
  libs,
  config,
  ...
}:
let
  system = "x86_64-linux";
in
{
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./pkgs
    ./configs
  ];

  home.stateVersion = "24.05";

  home.file = { };

  home.sessionVariables = {
    EDITOR = "lvim";
  };

  programs.home-manager.enable = true;
}
