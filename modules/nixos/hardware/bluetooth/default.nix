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
  cfg = config.${namespace}.hardware.bluetooth;
in
{
  options.${namespace}.hardware.bluetooth = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetooth support.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };
}
