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
  cfg = config.${namespace}.apps.gamescope;
in
{
  options.${namespace}.apps.gamescope = with types; {
    enable = mkBoolOpt false "Whether or not to enable gamescope.";
  };

  config = mkIf cfg.enable {
    programs.gamescope.enable = true;
  };
}
