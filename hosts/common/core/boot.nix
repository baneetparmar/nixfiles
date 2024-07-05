{ pkgs, ... }:
let
  cyberre-grub-theme =

    pkgs.stdenvNoCC.mkDerivation {
      pname = "cyberre-grub-theme";
      version = "1.0.0";

      src = pkgs.fetchzip {
        url = "https://tinyurl.com/cyberre-grub-theme";
        hash = "sha256-RWEQHqWjSZtDlFjJlsQBig/bBaZL/srfez1qTzE+Qrw=";
        recursiveHash = true;
        extension = "tar.gz";
      };

      installPhase = ''
        runHook preInstall

        mkdir $out
        cp -r $src/CyberRe/* $out/
      '';
    };
in
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = cyberre-grub-theme;
      };
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
    };
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
    ];
  };

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    themePackages = [ (pkgs.nixos-bgrt-plymouth) ];
  };

  boot.initrd = {
    verbose = false;
    kernelModules = [ "amdgpu" ];
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
