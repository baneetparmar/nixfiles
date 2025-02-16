{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  services.displayManager.defaultSession = "hyprland";

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = lib.mkForce [
  #     pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-kde
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  # };
}
