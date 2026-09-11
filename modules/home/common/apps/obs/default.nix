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
  cfg = config.${namespace}.apps.obs;
in
{
  options.${namespace}.apps.obs = with types; {
    enable = mkBoolOpt false "Whether or not to enable the OBS Studio screen recording and streaming software.";
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      # wlrobs/obs-vaapi/obs-vkcapture/obs-pipewire-audio-capture/obs-gstreamer
      # are all Linux (wlroots/VAAPI/Vulkan/PipeWire) specific - macOS
      # screen and audio capture work natively, no plugin needed.
      plugins =
        with pkgs.obs-studio-plugins;
        optionals pkgs.stdenv.isLinux [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-vaapi
          obs-gstreamer
          obs-vkcapture
        ];
    };
  };
}
