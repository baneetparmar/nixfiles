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
  cfg = config.${namespace}.apps.mpv;
in
{
  options.${namespace}.apps.mpv = with types; {
    enable = mkBoolOpt false "Whether or not to enable MPV.";
  };
  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [ autoload ];
    };
  };
}
