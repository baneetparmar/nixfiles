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
  cfg = config.${namespace}.services.passSecretService;
in
{
  # Fix applications not finding org.freedesktop.secrets
  options.${namespace}.services.passSecretService = with types; {
    enable = mkBoolOpt false "Whether or not to enable passSecretService.";
  };

  config = mkIf cfg.enable {
    services.passSecretService.enable = true;
  };
}
