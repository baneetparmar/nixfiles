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

    # required for using chaotic-nyx on stable channel
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];

  config.${namespace} = with lib.custom; {
    archetypes.gaming = enabled;
    misc = {
      nix-ld = enabled;
    };
  };

  config = {
    networking.hostName = "bellion";

    services.xserver.enable = true;
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
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
    ];

    services.preload.enable = true;

    system.stateVersion = globals.stateVersion;
  };

}
