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
  cfg = config.${namespace}.apps.gamescope;
in
{
  options.${namespace}.apps.gamescope = with types; {
    enable = mkBoolOpt false "Whether or not to enable gamescope.";
  };

  config = mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope-wsi.override { enableExecutable = true; };
      env = {
        ENABLE_HDR_WSI = "1";
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
      };
      args = [
        "-W 1920"
        "-H 1080"
        "-O DP-2"
        "-r 165"
        "-f"
        "--hdr-enabled"
        "--hdr-itm-enable"
        "--hide-cursor-delay 3000"
        "--fade-out-duration 200"
      ];
    };

  };
}
