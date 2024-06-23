{ pkgs-unstable, ... }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs-unstable.wezterm;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      config.enable_tab_bar = false
      config.window_background_opacity = 0.5

      return config
    '';
  };
}
