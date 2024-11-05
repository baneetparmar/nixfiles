{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    extraPackages = with pkgs; [
      steamcmd
      steam-tui
    ];
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };
  programs.steam.platformOptimizations.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    protonup
    lutris
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
  };
}
