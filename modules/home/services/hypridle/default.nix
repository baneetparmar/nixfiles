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
  cfg = config.${namespace}.services.hypridle;
in
{
  options.${namespace}.services.hypridle = with types; {
    enable = mkBoolOpt false "Whether or not to enable hypridle.";
  };
  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
  };
}
