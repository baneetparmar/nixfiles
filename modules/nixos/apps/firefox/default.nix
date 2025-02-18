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
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable firefox browser.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}
