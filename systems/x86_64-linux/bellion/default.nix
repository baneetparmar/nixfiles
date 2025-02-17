###############################################################
#                                                             #
#  BELLION - the strongest of the shadows, also my home pc    #
#  system specification = intel 12400 + amd 6600xt            #
#                                                             #
###############################################################

{
  lib,
  pkgs,
  config,
  inputs,
  channel,
  namespace,
  ...
}:

with lib;
with lib.${namespace};
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "bellion";

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.printing.enable = true;

  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
      if (subject.local) return "yes";
      });
    '';
  };

  environment.systemPackages = with pkgs; [
    piper
    udisks
    udiskie
    usbutils
    openrgb-with-all-plugins
    lxqt.lxqt-wayland-session
    inputs.nixvim.packages.${system}.default
  ];

  services.ratbagd.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
  };

  system.stateVersion = "24.11";
}
