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
  cfg = config.${namespace}.archetypes.workstation;
in
{
  options.${namespace}.archetypes.workstation = with types; {
    enable = mkBoolOpt false "Whether or not to enable Archetype: Workstation.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites = {
        base = enabled;
        desktop = enabled;
        programming = enabled;
      };
    };
  };
}
