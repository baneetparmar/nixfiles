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
  cfg = config.${namespace}.apps.mpv;
in
{
  options.${namespace}.apps.mpv = with types; {
    enable = mkBoolOpt false "Whether or not to enable the MPV media player.";
  };
  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [ autoload ];
      config = {
        profile = "gpu-hq";
        vo = "gpu-next";
        target-colorspace-hdr = "auto";
        target-colorspace-hint = "auto";
        hwdec = "auto";
        sub-file-paths = "$HOME/Videos/.subtitles/";
      }
      // forPlatform pkgs {
        linux = {
          gpu-api = "vulkan";
          gpu-context = "waylandvk";
        };
        darwin = {
          gpu-api = "auto";
        };
      };
    };
  };
}
