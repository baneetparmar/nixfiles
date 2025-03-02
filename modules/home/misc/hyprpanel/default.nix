{
  lib,
  namespace,
  inputs,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.misc.hyprpanel;
in
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  options.${namespace}.misc.hyprpanel = {
    enable = mkBoolOpt false "Whether or not to enable the Hyprpanel";
  };
  config = mkIf cfg.enable {
    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      hyprland.enable = true;
      overlay.enable = true;
    };
  };
}
