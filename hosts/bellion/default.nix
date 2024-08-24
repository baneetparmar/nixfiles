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
    ../common/core
    ../common/users/${username}
    ./hardware-configuration.nix
    # ./disko.nix

    # host specific config 
    ../common/optional/boot

    ../common/optional/steam.nix
    ../common/optional/hyprland.nix
    ../common/optional/pipewire.nix
    ../common/optional/waydroid.nix
    ../common/optional/nixhelper.nix
    ../common/optional/kdeconnect.nix
  ];

  networking.hostName = "bellion";

  #  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

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
    usbutils
    udiskie
    udisks
    gnome.nautilus
    gnome.file-roller
    inputs.nixvim.packages.${system}.default
  ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.gamemode.enable = true;

  system.stateVersion = "24.05";
}
