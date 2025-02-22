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
  cfg = config.${namespace}.apps.vesktop;
in
{
  options.${namespace}.apps.vesktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.vesktop ];
  };
}
