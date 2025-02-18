{
  pkgs,
  config,
  namespace,
  options,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.steam;
in
{
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];

  options.${namespace}.apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable steam.";
  };

  config = mkIf cfg.enable {

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
  };
}
