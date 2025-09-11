{
  lib,
  config,
  options,
  namespace,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktops.displayManager;
in
{
  options.${namespace}.desktops.displayManager = with types; {
    enable = mkBoolOpt false "Whether or not to enable Display Manager.";
    dm = mkOpt (enum [
      "sddm"
      "gdm"
    ]) "sddm" "available options: sddm, gdm.";
  };
  config = mkIf cfg.enable {
    services.displayManager.sddm = mkIf (cfg.dm == "sddm") {
      enable = true;
      wayland.enable = false;
      theme = "where_is_my_sddm_theme";
      package = lib.mkDefault pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [ qt6.qt5compat ];
      settings = {
        Theme = {
          CursorTheme = "phinger-cursors-dark";
        };
      };

    };

  };
}
