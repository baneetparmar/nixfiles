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
      hyprland.enable = true;
      overlay.enable = true;
      overwrite.enable = true;

      settings = {
        layout = {
          "bar.layouts" = {
            "0" = {
              left = [ "workspaces" ];
              middle = [ "media" ];
              right = [
                "systray"
                "volume"
                "network"
                "clock"
                "notifications"
                "dashboard"
              ];
            };
          };
        };
        bar = {
          clock = {
            format = "%a, %d  %H:%M";
            showIcon = false;
          };
          launcher = {
            autoDetectIcon = true;
          };
          media = {
            show_active_only = true;
          };
          network = {
            label = false;
          };
          notifications = {
            show_total = true;
          };
          workspaces = {
            workspaces = 10;
            showWsIcons = true;
          };
        };
        menus = {
          dashboard = {
            controls.enabled = false;
            directories.enabled = false;
            shortcuts.enabled = false;
            powermenu.avatar.image = "$HOME/.profile.png";
          };
          media = {
            displayTime = true;
          };
        };
        theme = {
          name = "monochrome";
          bar.transparent = true;
          font.size = "13px";
          font.weight = 500;
        };
      };
    };
  };
}
