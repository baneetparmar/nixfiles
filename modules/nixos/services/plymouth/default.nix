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
  cfg = config.${namespace}.services.plymouth;
in
{
  options.${namespace}.services.plymouth = with types; {
    enable = mkBoolOpt false "Whether or not to enable plymouth.";
  };
  config = mkIf cfg.enable {
    boot.plymouth.enable = true;
  };
}
