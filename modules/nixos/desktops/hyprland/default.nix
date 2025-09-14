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
  hypr-graphics = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.${namespace}.desktops.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland Window Manager.";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    # hardware.graphics = {
    #   package = mkForce hypr-graphics.mesa;
    #   package32 = mkForce hypr-graphics.pkgsi686Linux.mesa;
    # };
    programs.uwsm.enable = true;
  };
}
