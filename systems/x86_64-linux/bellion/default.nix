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

  ${namespace}.archetypes.gaming = enabled;

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
    inputs.nixvim.packages.${system}.default
  ];

  services.ratbagd.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.variables.EDITOR = "nvim";

  system.stateVersion = "24.11";
}
