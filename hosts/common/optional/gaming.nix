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
    extest.enable = true;

    extraPackages = with pkgs.legacy; [
      steamcmd
      steam-tui
    ];
    package = pkgs.legacy.steam.override {
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
    extraCompatPackages = with pkgs.unstable; [
      proton-ge-bin
    ];
  };
  programs.steam.platformOptimizations.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    wine
    wine64
    winetricks
    wineWowPackages.waylandFull
  ];
}
