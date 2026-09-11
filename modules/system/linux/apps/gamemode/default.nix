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
  cfg = config.${namespace}.apps.gamemode;
in
{
  options.${namespace}.apps.gamemode = with types; {
    enable = mkBoolOpt false "Whether or not to enable gamemode for games.";
  };

  config = mkIf cfg.enable {
    programs.gamemode.enable = true;
  };
}
