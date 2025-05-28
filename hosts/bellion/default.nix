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
    inputs.nur.modules.nixos.default
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
      vulkan-hdr-layer-kwin6
      where-is-my-sddm-theme
      lact # experimental
      gtk3
    ];
    zramSwap.enable = true;
    zramSwap.memoryPercent = 200;

    services.ratbagd.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.preload.enable = true;

    # glib schemas fix
    environment.variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";

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
