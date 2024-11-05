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
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ../common/optional/displayManager.nix

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

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

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
    udisks
    udiskie
    usbutils
    openrgb-with-all-plugins
    inputs.nixvim.packages.${system}.default
  ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "24.05";
}
