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
  cfg = config.${namespace}.desktops.plasma;
in
{
  options.${namespace}.desktops.plasma = with types; {
    enable = mkBoolOpt false "Whether or not to enable KDE Plasma Desktop Environment.";
    withSddm = mkBoolOpt false "Whether or not to enable SDDM Display Manager for Plasma.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.desktopManager.plasma6.enableQt5Integration = false;

    services.displayManager.sddm = mkIf cfg.withSddm {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
      package = lib.mkDefault pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [ qt6.qt5compat ];
      settings = {
        Theme = {
          CursorTheme = "phinger-cursors-dark";
        };
      };
    };
    qt = {
      enable = true;
      style = "kvantum";
      platformTheme = "qt5ct";
    };

    environment.systemPackages = with pkgs; [
      kora-icon-theme
      phinger-cursors
      graphite-kde-theme
      where-is-my-sddm-theme
    ];
  };
}
