{
  pkgs,
  config,
  options,
  namespace,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktops.hyprland;
in
{
  options.${namespace}.desktops.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland Window Manager.";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
