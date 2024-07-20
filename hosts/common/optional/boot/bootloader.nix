{ pkgs, ... }:
{
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      theme = pkgs.cyberre-grub-theme;
    };
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
  };
}
