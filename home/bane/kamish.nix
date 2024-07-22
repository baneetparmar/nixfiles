{ pkgs, username, ... }:
{
  imports = [
    ./common/core/git.nix
    ./common/core/bat.nix
    ./common/core/gpg.nix
    ./common/core/fish.nix
    ./common/core/direnv.nix
    ./common/core/ssh.nix
    ./common/core/fzf.nix
    ./common/core/starship.nix
    ./common/core/tealdeer.nix
    ./common/core/zoxide.nix

    #optional 
    ./common/optional/development.nix
  ];

  home = {
    inherit username;
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

    pinentry-curses
  ];
}
