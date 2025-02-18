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
  cfg = config.${namespace}.suites.media;
in
{
  options.${namespace}.suites.media = with types; {
    enable = mkBoolOpt false "Whether or not to enable common media tools.";
  };
  config = mkIf cfg.enable {
    # TODO: Add pkgs
  };
}
