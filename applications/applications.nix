{ pkgs, ... }: {
  imports = [
    ./ags.nix
    ./tofi.nix
    ./fish.nix
    ./aria2.nix
    ./yt-dlp.nix
    ./wezterm.nix
    ./spicetify.nix
    ./hypr/hypr.nix
    ./user-pkgs.nix
    ./hyprcursor-phinger.nix
  ];

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
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
    # package = pkgs-unstable.kdePackages.kdeconnect-kde;
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ autoload ];
  };

}
