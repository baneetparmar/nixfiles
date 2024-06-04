{ config, pkgs, pkgs-unstable, ... }:
let fonts = pkgs.nerdfonts.override { fonts = [ "Hack" "Iosevka" "IosevkaTerm" "JetBrainsMono" "SpaceMono" "UbuntuSans" ]; };
in
{
  home.packages = (with pkgs; [
    # =====  Dev tools & s/w ===== #
    gh
    git

    nurl
    cachix
    nixpkgs-fmt
    nix-prefetch-scripts

    gcc
    glibc
    gnumake
    lldb_16

    bacon
    rustup

    poetry
    python311
    python311Packages.pip
    python311Packages.jupyter
    python311Packages.pipx

    bun
    yarn
    nodejs_22
    nodePackages.ijavascript

    just
    tokei
    pinentry-curses

    # ===== Utils ===== #
    sd
    fd
    lf
    feh
    lsd
    fzf
    bat
    wget
    ncdu
    grex
    procs
    zoxide
    neovim
    zfxtop
    ripgrep
    lazygit
    tealdeer
    fastfetch
    bandwhich
    hyperfine
    tre-command
    pavucontrol

    # Ricing & hyprland stuff 
    tofi
    slurp
    sassc
    swappy
    du-dust
    dart-sass
    maple-mono
    hyprpicker
    wf-recorder
    google-fonts
    wl-clipboard
    inotify-tools
    brightnessctl
    maple-mono-NF

    # ===== Gnome pkgs ===== #
    gtk3
    amberol
    libadwaita
    accountsservice
    gnome.gnome-tweaks
    gnome.libgnome-keyring

    # ====== kde pkgs ======= #
    qt6.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum

    # <<<=== s-w === >>> #
    brave
    wayshot
    vesktop
    alsa-oss
    qbittorrent
    appimage-run
    google-chrome
    telegram-desktop

    # ====== misc ========= #
    krabby

  ])

  ++ (with pkgs-unstable; [
    # =====  Dev tools & s/w ===== #
    vscode

    #====== fonts ======== #
    fira-code-nerdfont

    # ======= utils ===== #
    lunarvim

    #====== Ricing & Hyprland Stuff
    wezterm
    nwg-look
    hyprcursor

    # ====== kde pkgs ======= #
    libsForQt5.qt5.qtwayland

    # ==== s-w ===== #
    miru
    varia
    gparted
    stremio
    obsidian
    localsend
  ])

  ++ ([
    fonts
  ]);

}
