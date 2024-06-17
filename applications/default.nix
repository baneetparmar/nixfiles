{ pkgs, pkgs-unstable, ... }: {
  imports = [

    ./neovim
    ./hyprland

    ./git.nix
    ./ags.nix
    ./tofi.nix
    ./fish.nix
    ./aria2.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./wezterm.nix
    ./programs.nix
    ./starship.nix
    ./pkgsList.nix
    ./spicetify.nix
    ./desktopEntries.nix
    ./hyprcursor-phinger.nix
  ];
}
