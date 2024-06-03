{ pkgs, pkgs-unstable, libs, ... }:
let system = "x86_64-linux";

in {
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  nixpkgs.config.allowUnfree = true;

  imports = [ ./config ./applications ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/bane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = { EDITOR = "lvim"; };

  fonts.fontconfig.enable = true;

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
    style.package = pkgs.whitesur-kde;
  };
  xdg.configFile = {
    "Kvantum/WhiteSur".source = "${pkgs.whitesur-kde}/Kvantum/WhiteSur";
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=WhiteSurDark
    '';
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
    theme = {
      package = pkgs.whitesur-gtk-theme.override { colorVariants = [ "Dark" ]; panelSize = "smaller"; nautilusStyle = "glassy"; };
      name = "WhiteSur-Dark";
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
    };
    font = {
      name = "Open Sans Regular";
      size = 10;
    };
  };

  programs.home-manager.enable = true;
}

