{
  lib,
  pkgs,
  config,
  options,
  namespace,
  ...
}:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.hardware.graphics;
in
{
  options.${namespace}.hardware.graphics = with types; {
    enable = mkBoolOpt false "Whether or not to enable graphics support";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    };

  };

}
