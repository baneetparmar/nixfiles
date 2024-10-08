{
  pkgs,
  outputs,
  username,
  ...
}:
{
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./aria.nix
    ./fish.nix
    ./zoxide.nix
    ./yt-dlp.nix
    ./direnv.nix
    ./starship.nix
    ./tealdeer.nix
    ./terminal.nix
  ];

  home = {
    username = "shadow";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  home.sessionPath = [
    "$HOME/.local/bin/"
    "$HOME/.cargo/bin/"
  ];
  home.sessionVariables = {
    FLAKE = "$HOME/.nixfiles";
  };

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    nurl
    cachix
    nixfmt-rfc-style
    nix-prefetch-scripts

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
    wayshot
    zathura

    pinentry-curses

    firefox

    (appimage-run.override { extraPkgs = p: [ p.libsecret ]; })
  ];
}
