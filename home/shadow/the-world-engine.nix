{
  lib,
  pkgs,
  inputs,
  globals,
  namespace,
  username,
  system,
  config,
  ...
}:
with lib;
with lib.${namespace};

{
  imports = [
    ../../modules/home/import.nix
    inputs.nur.modules.homeManager.default
  ];

  home = {
    username = lib.mkForce username;
    homeDirectory = lib.mkForce (homeDir system username);
    stateVersion = globals.stateVersion;
    sessionVariables = {
      FLAKE = "${homeDir system username}/.nixfiles";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11,*";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
    sessionPath = [
      "$HOME/.local/bin/"
      "$HOME/.cargo/bin/"
    ];
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  ${namespace} = {
    apps = {
      kitty = enabled;
      mpv = enabled;
      obs = enabled;
      rofi = enabled;
      spicetify = enabled;
    };
    desktops = {
      theme = enabled;
    };
    services = {
      ssh = enabled;
    };
    dev = {
      core = enabled;
    };
    tools = {
      aria = enabled;
      bat = enabled;
      direnv = enabled;
      fish = enabled;
      fzf = enabled;
      gh = enabled;
      git = enabled;
      gpg = enabled;
      starship = enabled;
      tealdeer = enabled;
      ytdlp = enabled;
      zoxide = enabled;
      nh = enabled;
    };
    misc = {
      ax-shell = enabled;
    };
  };
  home.packages = with pkgs; [
    sd
    fd
    lf
    lsd
    btop
    wget
    ncdu
    grex
    clipse
    ripgrep
    bandwhich
    pinentry-curses

    qview # image viewer
    glow # markdown reader
    zathura # ebook reader

    krabby

    (appimage-run.override { extraPkgs = p: [ p.libsecret ]; })

    nwg-look
    libadwaita
    nautilus
    file-roller
    gnome-tweaks
    accountsservice
    libgnome-keyring

    stremio-linux-shell
    alsa-oss
    google-chrome

    miru
    vesktop
    qbittorrent

    unstable.rquickshare
    unstable.signal-desktop

    freedownload-manager
    nur.repos.hexadecimalDinosaur.jetbrains-fleet
  ];
}
