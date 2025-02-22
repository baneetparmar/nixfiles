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
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable desktop packages and settings.";
  };
  config = mkIf cfg.enable {
    ${namespace} = {
      apps = {
        vesktop = enabled;
      };
      desktops.hyprland = enabled;
    };
  };
}
