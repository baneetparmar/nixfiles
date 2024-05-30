{pkgs, ...}:{
  imports = [
    # ./tofi.nix
    ./ags.nix
    ./aria2.nix
    ./yt-dlp.nix
    ./matugen.nix
    ./spicetify.nix
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
    pinentryFlavor = "curses";

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
