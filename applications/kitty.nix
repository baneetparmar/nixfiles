{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    shellIntegration = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    environment = { "LS_COLORS" = "1"; };
    settings = {
      scrollback_lines = 10000;
      disable_ligatures = "never";

      cursor_shape = "block";

      repaint_delay = 6;
      detect_urls = "yes";
      window_padding_width = 10;
      confirm_os_window_close = 0;

      tab_bar_style = "hidden";

      background_opacity = "0.6";
      background_blur = 5;
    };
  };
}
