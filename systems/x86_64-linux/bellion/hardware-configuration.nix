{
  lib,
  pkgs,
  config,
  inputs,
  modulesPath,
  ...
}:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
    common-pc-ssd
    common-gpu-amd
    common-cpu-intel
  ];

  boot.initrd.availableKernelModules = [
    "vmd"
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
    "amdgpu"
  ];
  boot.extraModulePackages = [ ];
  hardware.bluetooth.enable = true;

  networking.useDHCP = lib.mkDefault true;

  hardware.enableRedistributableFirmware = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
