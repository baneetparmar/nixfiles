{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
      "amdgpu"
    ];
  };
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    themePackages = [ (pkgs.nixos-bgrt-plymouth) ];
  };

  boot.initrd = {
    verbose = false;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
  };
  swapDevices = [ ];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 200;

  # appimage patch
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
