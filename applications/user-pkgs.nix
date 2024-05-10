{ config, pkgs, pkgs-unstable, ... }: {
  home.packages = (with pkgs; [
    # =====  Dev tools & s/w ===== #
    gh
    git

    gcc
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
    nodejs_21
    nodePackages.ijavascript

    tokei
    cachix
    nixpkgs-fmt
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
    lunarvim
    fastfetch
    bandwhich
    hyperfine
    tre-command
    pavucontrol

    # Ricing & hyprland stuff 
    tofi
    swww
    slurp
    sassc
    swappy
    du-dust
    dart-sass
    hyprpaper
    maple-mono
    hyprpicker
    wf-recorder
    google-fonts
    wl-clipboard
    inotify-tools
    brightnessctl
    maple-mono-NF
    reversal-icon-theme
    whitesur-icon-theme

    # ===== Gnome pkgs ===== #
    gtk3
    amberol
    libadwaita
    accountsservice
    gnome.gnome-tweaks
    gnome.libgnome-keyring

    # ====== kde pkgs ======= #
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum

    # <<<=== s-w === >>> #
    mpd
    wayshot
    vesktop
    ncmpcpp
    appimage-run
    google-chrome
    telegram-desktop
    openrgb-with-all-plugins

  ])

    ++ (with pkgs-unstable; [
      # =====  Dev tools & s/w ===== #
      vscode

      #====== Ricing & Hyprland Stuff
      wezterm
      nwg-look
      hyprlock
      hypridle
      hyprcursor
      phinger-cursors

      # ====== kde pkgs ======= #

      # ==== s-w ===== #
      librum
      stremio
      obsidian
      localsend
      qbittorrent
    ]);

}
