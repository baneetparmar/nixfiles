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
    withPlugins = mkBoolOpt false "Whether or not enable plugins for OpenRGB.";
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb.enable = true;
    environment.systemPackages = mkIf cfg.withPlugins pkgs.openrgb-with-all-plugins;
  };
}
