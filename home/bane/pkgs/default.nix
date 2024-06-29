{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./rofi
    ./nixvim
    ./hyprland

    ./git.nix
    ./ags.nix
    ./pkgs.nix
    ./fish.nix
    ./aria2.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./wezterm.nix
    ./programs.nix
    ./starship.nix
    ./spicetify.nix
    ./desktopEntries.nix
    ./hyprcursor-phinger.nix
  ];
}
