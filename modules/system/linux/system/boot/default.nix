{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.boot;
in
{
  options.${namespace}.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting on the system";
  };

  config = mkIf cfg.enable {

    boot = {
      loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
        };
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = false;
      };

      tmp.cleanOnBoot = true;
      supportedFilesystems = [ "ntfs" ];
      kernelPackages = pkgs.linuxPackages_zen;
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
  };
}
