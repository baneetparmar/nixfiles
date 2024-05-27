{ pkgs, libs, ... }:
let system = "x86_64-linux";

in {
  home.username = "bane";
  home.homeDirectory = "/home/bane";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config/git.nix
    ./applications/ags.nix
    ./applications/matugen.nix
    ./applications/spicetify.nix
    ./applications/user-pkgs.nix
    ./applications/hyprcursor-phinger.nix
    # ./config/stylix.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file = { };

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/bane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = { EDITOR = "lvim"; };

  fonts.fontconfig.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      eh = "home-manager edit";
      hup =
        "cd ~/.dotfiles && nix flake update && home-manager switch --flake ~/.dotfiles/ && cd ~";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";

    };
    shellInit =
      "\n      fish_config theme choose 'RosePineMoon'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
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

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ autoload ];
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=WhiteSurDark
    '';
    "Kvantum/WhiteSurKde".source = "${pkgs.whitesur-kde}/Kvantum/WhiteSur";
  };

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.phinger-cursors;
    cursorTheme.name = "phinger-cursors";
    theme.package = pkgs.whitesur-gtk-theme;
    theme.name = "WhiteSur-Dark";
    iconTheme.package = pkgs.whitesur-icon-theme;
    iconTheme.name = "WhiteSur-dark"; 
  };
  
  programs.home-manager.enable = true;
}

