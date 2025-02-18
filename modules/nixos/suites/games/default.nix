{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.games;

in
{
  options.${namespace}.suites.games = with types; {
    enable = mkBoolOpt false "Whether or not to enable common game configurations.\n
    (enables steam, gamemode, gamescope, lutris, wine & some other things)";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        steam = enabled;
        gamescope = enabled;
        gamemode = enabled;
      };
    };

    environment.systemPackages = with pkgs; [
      lutris
      wine
      wine64
      mangohud
      winetricks
      wineWowPackages.waylandFull
    ];
  };
}
