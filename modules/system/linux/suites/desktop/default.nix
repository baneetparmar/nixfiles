{
  lib,
  config,
  namespace,
  options,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      desktops = {
        displayManager = {
          enable = true;
          dm = "sddm";
        };
        hyprland = enabled;
      };

      apps = {
        firefox = enabled;
        neovim = enabled;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-hyprland
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    zramSwap.enable = true;
    zramSwap.memoryPercent = 200;

    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
