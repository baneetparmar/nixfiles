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
  cfg = config.${namespace}.system.locale;
in
{
  options.${namespace}.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to set locale.";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
