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
  cfg = config.${namespace}.apps.kdeconnect;
in
{
  options.${namespace}.apps.kdeconnect = with types; {
    enable = mkBoolOpt false "Whether or not to install KDE-connect.";
  };

  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
