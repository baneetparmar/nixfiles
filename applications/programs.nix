{ pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    gpg.enable = true;

    mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [ autoload ];
    };

    fd.enable = true;

    lf.enable = true;

    feh.enable = true;

    lsd.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    ripgrep.enable = true;

    lazygit.enable = true;

    tealdeer = {
      enable = true;
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 24;
      };
    };

    fastfetch.enable = true;
  };
}
