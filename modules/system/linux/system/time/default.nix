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
  cfg = config.${namespace}.system.time;
in
{
  options.${namespace}.system.time = with types; {
    enable = mkBoolOpt false "Whether or not to set timezone.";
  };

  config = mkIf cfg.enable {
    time = {
      timeZone = "Asia/Kolkata";
      hardwareClockInLocalTime = true; # fix windows time de-sync
    };
  };
}
