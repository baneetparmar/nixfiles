{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # =====  Dev tools & s/w ===== #
    vscode

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
    hyprcursor
    hyprpicker
    wf-recorder
    wl-clipboard
    inotify-tools
    brightnessctl

    # ===== Gnome pkgs ===== #
    gtk3
    amberol
    foliate
    nwg-look
    libadwaita
    accountsservice
    gnome.gnome-tweaks
    gnome.libgnome-keyring

    # ====== kde pkgs ======= #
    qview
    qbittorrent

    # <<<=== s-w === >>> #
    glow
    brave
    varia
    sioyek
    krabby
    clipse
    stremio
    wayshot
    vesktop
    alsa-oss
    libsecret
    localsend
    appimage-run
    google-chrome
    telegram-desktop
  ];
}
