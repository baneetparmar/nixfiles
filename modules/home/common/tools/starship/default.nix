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
  cfg = config.${namespace}.tools.starship;
in
{
  options.${namespace}.tools.starship = with types; {
    enable = mkBoolOpt false "Whether or not to enable starhip.";
  };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    programs.starship.settings = {
      add_newline = true;

      scan_timeout = 10;

      username = {
        show_always = true;
        disabled = false;
      };

      hostname = {
        ssh_only = false;
        disabled = false;
      };
    };
  };

}
