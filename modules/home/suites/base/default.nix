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
  cfg = config.${namespace}.suites.base;
in
{
  options.${namespace}.suites.base = with types; {
    enable = mkBoolOpt false "Whether or not to enable base packages and settings.";
  };
  config = mkIf cfg.enable {
    ${namespace} = {
      apps = { };
    };
  };
}
