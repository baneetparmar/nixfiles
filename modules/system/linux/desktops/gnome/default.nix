{
  lib,
  pkgs,
  config,
  options,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktops.gnome;
in
{
  options.${namespace}.desktops.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable gnome desktop enviroment";
    withGDM = mkBoolOpt false "Whether or not to enable GDM display manager.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    ${namespace}.desktops.displayManager = mkIf cfg.withGDM {
      enable = true;
      dm = "gdm";
    };

    programs.dconf.enable = true;
    services.udev.packages = [ pkgs.gnome-settings-daemon ];

    environment.systemPackages = [
      pkgs.gnomeExtensions.appindicator
    ];
  };
}
