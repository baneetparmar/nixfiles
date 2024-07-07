{ ... }:
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
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
