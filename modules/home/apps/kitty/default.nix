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
  cfg = config.${namespace}.apps.kitty;
in
{
  options.${namespace}.apps.kitty = with types; {
    enable = mkBoolOpt false "Whether or not to enable Kitty Terminal.";
  };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "Fantasque Sans Mono";
        size = 13;
      };
      shellIntegration = {
        enableFishIntegration = true;
        enableBashIntegration = true;
      };
      environment = {
        "LS_COLORS" = "1";
      };
      settings = {
        scrollback_lines = 10000;
        disable_ligatures = "never";

        cursor_shape = "block";

        repaint_delay = 6;
        detect_urls = "yes";
        window_padding_width = 10;
        confirm_os_window_close = 0;

        tab_bar_style = "hidden";

        background_opacity = "0.9";
        background_blur = 1;
      };

      extraConfig = '''';
    };
  };
}
