###############################################################
#                                                             #
#  bellion - the strongest of the shadows, also my home pc    #
#  configuration = intel 12400 + amd 6600xt                   #
#                                                             #
###############################################################

{
  inputs,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./disko.nix
    ../common/core
    ../common/users/${username}
    ./hardware-configuration.nix
    ../common/optional/displayManager.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # host specific config
    ./stylix.nix
    ../common/optional/boot

    ../common/optional/gaming.nix
    ../common/optional/services.nix
    ../common/optional/hyprland.nix
    ../common/optional/pipewire.nix
    ../common/optional/nixhelper.nix
    ../common/optional/kdeconnect.nix

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
