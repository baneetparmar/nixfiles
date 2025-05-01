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
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      desktops.displayManager = {
        enable = true;
        dm = "sddm";
      };
      desktops.hyprland = enabled;

      apps = {
        firefox = enabled;
        kdeconnect = enabled;
      };
    };
  };
}
