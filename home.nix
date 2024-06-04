{ pkgs, pkgs-unstable, libs, ... }:
let system = "x86_64-linux";

in {
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  nixpkgs.config.allowUnfree = true;

  imports = [ ./config ./applications ];

  home.stateVersion = "24.05";

  home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/bane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = { EDITOR = "lvim"; };

  programs.home-manager.enable = true;
}

