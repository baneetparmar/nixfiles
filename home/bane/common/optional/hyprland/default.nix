{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    wayshot
    slurp
    mpvpaper
    hyprcursor
    hyprpicker
    wf-recorder
    wl-clipboard
    inotify-tools
  ];
}
