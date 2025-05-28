{
  lib,
  pkgs,
  inputs,
  globals,
  namespace,
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
    username = "${globals.username}";
    homeDirectory = "/home/${globals.username}";
    stateVersion = globals.stateVersion;
    sessionVariables = {
      FLAKE = "/home/${globals.username}/.nixfiles";
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
      vscode = enabled;
      spicetify = enabled;
    };
    desktops = {
      theme = enabled;
    };
    services = {
      ssh = enabled;
    };
    development = {
      misc-env = enabled;
      python-env = enabled;
      rust-env = enabled;
      webdev-env = enabled;
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
    lazygit
    bandwhich

    glow # markdown reader
    krabby
    zathura

    pinentry-curses

    (appimage-run.override { extraPkgs = p: [ p.libsecret ]; })

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

    miru
    vesktop
    qbittorrent
    gitmoji-cli
    signal-desktop
    element-desktop

    unstable.rquickshare
  ];
}
