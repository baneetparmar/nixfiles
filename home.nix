{ pkgs, pkgs-unstable, libs, ... }:
let system = "x86_64-linux";

in {
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  nixpkgs.config.allowUnfree = true;

  imports = [ ./config/config.nix ./applications/applications.nix ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/bane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = { EDITOR = "lvim"; };

  fonts.fontconfig.enable = true;
  
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=WhiteSurDark
    '';
    "Kvantum/WhiteSurKde".source = "${pkgs.whitesur-kde}/Kvantum/WhiteSur";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };
    theme = {
      package = pkgs.whitesur-gtk-theme;
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

