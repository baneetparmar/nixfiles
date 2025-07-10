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

        background_opacity = "1";
        # background_blur = 0;
      };

      extraConfig = ''
        # special
        active_border_color     #edecee
        inactive_border_color   #21202e
        bell_border_color       #ffca85
        url_color               #61ffca

        active_tab_foreground   #edecee
        active_tab_background   #21202e
        inactive_tab_foreground #4d4d4d
        inactive_tab_background #21202e

        cursor                  #edecee
        foreground              #edecee
        background              #21202e
        selection_foreground    #edecee
        selection_background    #1c1b22

        # black
        color0                  #1c1b22
        color8                  #4d4d4d

        # red
        color1                  #ff6767
        color9                  #ffca85

        # green
        color2                  #61ffca
        color10                 #a277ff

        # yellow
        color3                  #ffca85
        color11                 #ffca85

        # blue
        color4                  #a277ff
        color12                 #a277ff

        # magenta
        color5                  #a277ff
        color13                 #a277ff

        # cyan
        color6                  #61ffca
        color14                 #61ffca

        # white
        color7                  #edecee
        color15                 #edecee

        # special
        active_border_color     #edecee
        inactive_border_color   #21202e
        bell_border_color       #ffca85
        url_color               #61ffca

        active_tab_foreground   #edecee
        active_tab_background   #21202e
        inactive_tab_foreground #4d4d4d
        inactive_tab_background #21202e

        cursor                  #edecee
        foreground              #edecee
        background              #21202e
        selection_foreground    #edecee
        selection_background    #1c1b22

        # black
        color0                  #1c1b22
        color8                  #4d4d4d

        # red
        color1                  #ff6767
        color9                  #ffca85

        # green
        color2                  #61ffca
        color10                 #a277ff

        # yellow
        color3                  #ffca85
        color11                 #ffca85

        # blue
        color4                  #a277ff
        color12                 #a277ff

        # magenta
        color5                  #a277ff
        color13                 #a277ff

        # cyan
        color6                  #61ffca
        color14                 #61ffca

        # white
        color7                  #edecee
        color15                 #edecee
      '';
    };
  };
}
