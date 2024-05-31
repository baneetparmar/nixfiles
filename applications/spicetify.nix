{ pkgs, lib, spicetify-nix, ... }:
let spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ hidePodcasts adblock ];

    colorScheme = "custom";
    customColorScheme = {
      text = "ebbcba";
      subtext = "F0F0F0";
      sidebar-text = "e0def4";
      main = "191724";
      sidebar = "2a2837";
      player = "191724";
      card = "191724";
      shadow = "1f1d2e";
      selected-row = "797979";
      button = "31748f";
      button-active = "31748f";
      button-disabled = "555169";
      tab-active = "ebbcba";
      notification = "1db954";
      notification-error = "eb6f92";
      misc = "6e6a86";
    };
  };
}
