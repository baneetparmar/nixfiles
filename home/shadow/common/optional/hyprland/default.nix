{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    sassc
    slurp
    wayshot
    mpvpaper
    hyprcursor
    hyprpicker
    wf-recorder
    wl-clipboard
    inotify-tools
    gtk-session-lock
    python312Packages.gpustat
  ];
}
