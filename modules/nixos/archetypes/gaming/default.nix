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
  cfg = config.${namespace}.archetypes.gaming;
in
{
  options.${namespace}.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to make this system awesome.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      suites.games = enabled;
      suites.base = enabled;
      suites.desktop = enabled;
      suites.media = enabled;
    };
  };
}
