{
  lib,
  pkgs,
  config,
  options,
  namespace,
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
        amdvlk
        libva
        libva-utils
        libvdpau-va-gl
        intel-media-driver
        intel-vaapi-driver
        rocmPackages.clr.icd
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        amdvlk
        intel-vaapi-driver
      ];
    };

    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
      LIBVA_DRIVER_NAME = "iHD";
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-headers
      vulkan-validation-layers
    ];

    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  };

}
