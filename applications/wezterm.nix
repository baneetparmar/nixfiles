{ pkgs-unstable, ... }: {
  programs.wezterm = {
    enable = true;
    package = pkgs-unstable.wezterm;
    extraConfig =
      ''
        local wezterm = require 'wezterm'
        local config = {}

        config.enable_wayland = false
        config.enable_tab_bar = false
        config.window_background_opacity = 0.4

        return config
      '';
  };
}
