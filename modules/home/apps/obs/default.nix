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
  cfg = config.${namespace}.apps.obs;
in
{
  options.${namespace}.apps.obs = with types; {
    enable = mkBoolOpt false "Whether or not to enable the OBS Studio screen recording and streaming software.";
  };
  config = mkIf cfg.enable {
    programs.obs-studio.enable = true;
    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };
}
