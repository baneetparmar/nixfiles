{ pkgs, pkgs-unstable, ... }: {
  imports = [
    ./hyprland
    ./tofi.nix
    ./fish.nix
    ./aria2.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./wezterm.nix
    ./ags/ags.nix
    ./pkgsList.nix
    ./spicetify.nix
    ./hyprcursor-phinger.nix
  ];
}
