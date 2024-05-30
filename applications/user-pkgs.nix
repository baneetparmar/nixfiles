{ config, pkgs, pkgs-unstable, ... }: {
  home.packages = (with pkgs; [
    # =====  Dev tools & s/w ===== #
    gh
    git

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
    ydotool
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

    # ===== Gnome pkgs ===== #
    gtk3
    amberol
    libadwaita
    accountsservice
    gnome.gnome-tweaks
    gnome.libgnome-keyring

    # ====== kde pkgs ======= #
    qt6.qtwayland

    # <<<=== s-w === >>> #
    mpd
    brave
    wayshot
    vesktop
    ncmpcpp
    alsa-oss
    persepolis
    qbittorrent
    appimage-run
    google-chrome
    uget-integrator
    telegram-desktop
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

      # ====== kde pkgs ======= #
      libsForQt5.qt5.qtwayland

      # ==== s-w ===== #
      miru
      librum
      stremio
      obsidian
      localsend
    ]);

}
