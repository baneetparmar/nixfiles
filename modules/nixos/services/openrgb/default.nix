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
  cfg = config.${namespace}.services.openrgb;
in
{
  options.${namespace}.services.openrgb = with types; {
    enable = mkBoolOpt false "Whether or not to enable OpenRGB.";
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb.enable = true;
  };
}
