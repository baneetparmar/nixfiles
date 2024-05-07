{inputs, config, pkgs, pkgs-unstable, ... }: {
  home.packages = ( with pkgs; [
    # =====  Dev tools & s/w ===== #
    gh
    git
    
    gcc
    gnumake
    lldb_16

    rustup
    
    poetry
    python311
    python311Packages.pip
    python311Packages.jupyter
    python311Packages.pipx

    bun
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
    grex
    procs
    zoxide
    neovim
    zfxtop
    ripgrep
    lazygit
    tealdeer
    lunarvim
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
    hyprpicker
    wf-recorder
    google-fonts
    wl-clipboard
    inotify-tools
    brightnessctl
    reversal-icon-theme
    whitesur-icon-theme

    # ===== Gnome pkgs ===== #
    gtk3
    amberol
    libadwaita
    accountsservice
    gnome.libgnome-keyring
    gnome.gnome-tweaks
    xdg-desktop-portal-gnome

    # <<<=== s/w === >>> #
    mpv
    wayshot
    stremio
    vesktop 
    ncmpcpp
    qbittorrent
    telegram-desktop
    
  ])

  ++( with pkgs-unstable; [
    # =====  Dev tools & s/w ===== #
    vscode

    #====== Ricing & Hyprland Stuff
    anyrun
    wezterm
    hyprlock
    hypridle
    hyprcursor
    phinger-cursors
    xdg-desktop-portal-hyprland

    # ==== s/w ===== #
  ]);

}
