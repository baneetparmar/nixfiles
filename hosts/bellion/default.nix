{
  lib,
  pkgs,
  config,
  inputs,
  namespace,
  globals,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    inputs.nix-snapd.nixosModules.default
  ];

  config.${namespace} = with lib.custom; {
    archetypes.gaming = enabled;
    misc = {
      nix-ld = enabled;
    };
  };

  config = {
    networking.hostName = "bellion";

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
    services.scx.enable = true;
    services.scx.scheduler = "scx_lavd";
    services.xserver.videoDrivers = [ "amdgpu" ];

    services.snap.enable = true;

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
      vulkan-hdr-layer
      where-is-my-sddm-theme
      lact # experimental
    ];
    zramSwap.enable = true;
    zramSwap.memoryPercent = 200;

    services.ratbagd.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    # Experimental Stuff
    hardware.amdgpu.opencl.enable = true;
    hardware.amdgpu.initrd.enable = true;
    hardware.intel-gpu-tools.enable = true;
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = [ "multi-user.target" ];
    ######

    system.stateVersion = globals.stateVersion;
  };

}
