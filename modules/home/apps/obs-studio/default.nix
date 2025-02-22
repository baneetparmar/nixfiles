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
  cfg = config.${namespace}.apps.obs-studio;
in
{
  options.${namespace}.apps.obs-studio = with types; {
    enable = mkBoolOpt false "Whether or not to enable OBS Studio.";
  };

  config = mkIf cfg.enable {
    programs.obs-studio.enable = true;
    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };
}
