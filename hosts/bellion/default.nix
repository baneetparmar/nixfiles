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
    kernel.sysctl = {
      "vm.swappiness" = 180; # for better zram usage
    };
    zramSwap.enable = true;
    zramSwap.memoryPercent = 200;

    system.stateVersion = globals.stateVersion;
  };

}
