{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      nurl
      cachix
      nixfmt-rfc-style
      nix-prefetch-scripts

      gcc
      glibc
      gnumake
      lldb_16

      bacon
      rustup

      pipx
      poetry
      python312
      python312Packages.pip

      bun
      yarn
      nodejs_22
      nodePackages.ijavascript

      just
      tokei
      pinentry-curses

      # ===== Utils ===== #
      sd
      btop
      wget
      ncdu
      grex
      bandwhich
      hyperfine
      pavucontrol

      # Ricing & hyprland stuff
      slurp
      sassc
      swappy
      du-dust
      mpvpaper
      dart-sass
      hyprpicker
      wf-recorder
      wl-clipboard
      inotify-tools
      brightnessctl

      # ===== Gnome pkgs ===== #
      gtk3
      amberol
      foliate
      libadwaita
      accountsservice
      gnome.gnome-tweaks
      gnome.libgnome-keyring

      # ====== kde pkgs ======= #

      # <<<=== s-w === >>> #
      brave
      wayshot
      vesktop
      alsa-oss
      libsecret
      qbittorrent
      appimage-run
      google-chrome
      telegram-desktop

      # ====== misc ========= #
      qview
      sioyek
      krabby
    ])
    ++ (with pkgs-unstable; [
      # =====  Dev tools & s/w ===== #
      vscode

      # ======= utils ===== #

      #====== Ricing & Hyprland Stuff
      nwg-look
      hyprcursor

      # ====== kde pkgs ======= #

      # ==== s-w ===== #
      varia
      stremio
      localsend
    ]);
}
