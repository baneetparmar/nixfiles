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
    enable-sddm = mkBoolOpt false "Whether or not to enable SDDM Display Manager for Plasma.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = mkIf cfg.enable-sddm {
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
    environment.systemPackages = with pkgs; [
      where-is-my-sddm-theme
      phinger-cursors
    ];
  };
}
