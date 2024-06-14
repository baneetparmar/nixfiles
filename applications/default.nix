{ pkgs, pkgs-unstable, ... }: {
  imports = [

    ./neovim
    ./hyprland

    ./tofi.nix
    ./fish.nix
    ./aria2.nix
    ./kitty.nix
    ./yt-dlp.nix
    ./wezterm.nix
    ./ags.nix
    ./programs.nix
    ./pkgsList.nix
    ./spicetify.nix
    ./desktopEntries.nix
    ./hyprcursor-phinger.nix
  ];
}
