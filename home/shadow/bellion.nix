{ inputs, pkgs, ... }:
{
  imports = [
    ./common/core

    # optional pkgs
    ./common/optional/rofi
    # ./common/optional/ags.nix
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
      nautilus
      file-roller
      gnome-tweaks
      accountsservice
      libgnome-keyring

      qview

      varia
      stremio
      alsa-oss
      localsend
      google-chrome
      notion-desktop
      wora-music-player
      google-play-books
      inputs.ags.packages.${pkgs.system}.default

      beeper
    ])
    ++ (with pkgs.unstable; [
      miru
      cider
      whatsie
      vesktop
      zed-editor
      qbittorrent
      gitmoji-cli
      signal-desktop
      element-desktop
    ]);
}
