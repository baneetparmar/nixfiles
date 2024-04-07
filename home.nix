{ config, pkgs, ... }:
let system = "x86_64-linux";


in {
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./git.nix
    ./user-pkgs.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/bane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "lvim";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      eh = "home-manager edit";
      hup = "cd ~/.dotfiles && nix flake update && home-manager switch --flake ~/.dotfiles/ && cd ~";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";



    };
    shellInit = "
      fish_config theme choose 'Dracula Official'
      direnv hook fish | source
      zoxide init fish | source
    ";
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";

  };
  programs.home-manager.enable = true;
}

