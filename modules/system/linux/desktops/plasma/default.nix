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
    withSDDM = mkBoolOpt false "Whether or not to enable SDDM Display Manager for Plasma.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.desktopManager.plasma6.enableQt5Integration = false;

    ${namespace}.desktops.displayManager = mkIf cfg.withSDDM {
      enable = true;
      dm = "sddm";
    };

    environment.systemPackages = with pkgs; [
      kora-icon-theme
      phinger-cursors
      graphite-kde-theme
    ];
  };
}
