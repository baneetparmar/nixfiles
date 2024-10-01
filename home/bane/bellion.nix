{ pkgs, ... }:
{
  imports = [
    ./common/core

    # optional pkgs
    ./common/optional/rofi
    ./common/optional/ags.nix
    ./common/optional/mpv.nix
    ./common/optional/hyprland
    ./common/optional/theme.nix
    ./common/optional/obs-studio.nix
    ./common/optional/qutebrowser.nix
    ./common/optional/development.nix
    ./common/optional/spicetify-nix.nix
    ./common/optional/hyprcursor-phinger.nix
  ];

  home.packages =
    (with pkgs; [

      gtk3
      amberol
      nwg-look
      libadwaita
      accountsservice
      gnome.gnome-tweaks
      gnome.libgnome-keyring

      qview

      varia
      stremio
      alsa-oss
      localsend
      google-chrome
      notion-desktop
      wora-music-player
      google-play-books
    ])
    ++ (with pkgs.unstable; [
      miru
      beeper
      lutris
      vesktop
      zed-editor
      gitmoji-cli
      qbittorrent
    ]);
}
