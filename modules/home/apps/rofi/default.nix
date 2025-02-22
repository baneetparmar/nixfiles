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
  cfg = config.${namespace}.apps.rofi;
in
{
  options.${namespace}.apps.rofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable Rofi.";
  };

  config = mkIf cfg.enable {
    programs.rofi.enable = true;
    programs.rofi.package = pkgs.rofi-wayland;
    programs.rofi.theme = "black.rasi";

    xdg.configFile."rofi/black.rasi".source = ./black.rasi;
  };
}
