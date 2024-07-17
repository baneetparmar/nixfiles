{ ... }:
{
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

      background_opacity = "0.8";
      background_blur = 0;
    };

    extraConfig = ''
      ## name: Tokyo Night Storm
      ## license: MIT
      ## author: Folke Lemaitre
      ## upstream: https://github.com/folke/tokyonight.nvim/raw/main/extras/kitty/tokyonight_storm.conf


      background #24283b
      foreground #c0caf5
      selection_background #2e3c64
      selection_foreground #c0caf5
      url_color #73daca
      cursor #c0caf5
      cursor_text_color #24283b

      # Tabs
      active_tab_background #7aa2f7
      active_tab_foreground #1f2335
      inactive_tab_background #292e42
      inactive_tab_foreground #545c7e
      #tab_bar_background #1d202f

      # Windows
      active_border_color #7aa2f7
      inactive_border_color #292e42

      # normal
      color0 #1d202f
      color1 #f7768e
      color2 #9ece6a
      color3 #e0af68
      color4 #7aa2f7
      color5 #bb9af7
      color6 #7dcfff
      color7 #a9b1d6

      # bright
      color8 #414868
      color9 #f7768e
      color10 #9ece6a
      color11 #e0af68
      color12 #7aa2f7
      color13 #bb9af7
      color14 #7dcfff
      color15 #c0caf5

      # extended colors
      color16 #ff9e64
      color17 #db4b4b
    '';
  };
}
