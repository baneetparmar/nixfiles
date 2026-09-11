{
  lib,
  namespace,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.hyprsunset;
in
{
  options.${namespace}.services.hyprsunset = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprsunset.";
  };
  config = mkIf cfg.enable {
    services.hyprsunset.enable = true;
  };
}
