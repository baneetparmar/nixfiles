{
  lib,
  config,
  namespace,
  options,
  pkgs,
  ...
}:

with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.hardware.graphics;
in
{
  options.${namespace}.hardware.graphics = with types; {
    enable = mkBoolOpt false "Whether or not to enable graphics support";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        libva-vdpau-driver
        libvdpau-va-gl
        intel-media-driver
        intel-vaapi-driver # older but works better for Firefox & Chrome
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        intel-vaapi-driver
      ];
    };

    environment.variables = {
      AMD_VULKAN_ICD = "RADV"; # use mesa drivers instead of amdvlk.
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
    ];

    hardware.amdgpu.opencl.enable = true;
    hardware.amdgpu.initrd.enable = true;

    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  };

}
