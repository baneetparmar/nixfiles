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
    ./common/optional/development.nix
    ./common/optional/spicetify-nix.nix
    ./common/optional/hyprcursor-phinger.nix
  ];

  home.packages =
    (with pkgs; [

      cz-cli

      gtk3
      amberol
      foliate
      nwg-look
      libadwaita
      accountsservice
      gnome.gnome-tweaks
      gnome.libgnome-keyring

      qview

      brave
      varia
      vesktop
      alsa-oss
      localsend
      google-chrome
      notion-desktop
      wora-music-player
      google-play-books
    ])
    ++ (with pkgs.unstable; [
      beeper
      miru
      stremio
      qbittorrent
      zed-editor
    ]);
}
