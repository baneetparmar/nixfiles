{ pkgs, ... }:
{
  imports = [
    ./plymouth.nix
    ./bootloader.nix
    ./appimage-patch.nix
  ];
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
    ];
    initrd = {
      verbose = false;
      kernelModules = [ "amdgpu" ];
    };
    kernel.sysctl = {
      "vm.swappiness" = 180; # for better zram usage
    };
  };
  zramSwap.enable = true;
  zramSwap.memoryPercent = 200;
}
