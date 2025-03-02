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
  cfg = config.${namespace}.tools.tealdeer;
in
{
  options.${namespace}.tools.tealdeer = with types; {
    enable = mkBoolOpt false "Whether or not to enable Tealdeer aka tldr.";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 24;
      };
    };
  };
}
