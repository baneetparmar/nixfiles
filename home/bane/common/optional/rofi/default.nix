{ pkgs, ... }:
{

  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  programs.rofi.theme = "black.rasi";

  xdg.configFile."rofi/black.rasi".source = ./black.rasi;
}
