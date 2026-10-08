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
  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable pipewire audio support.";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = "[ 44100 48000 88200 96000 192000 ]";
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 2048;
        "default.clock.quantum-limit" = 8192;
        "resample.quality" = 10;
      };
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
      pulsemixer
      easyeffects
    ];
  };
}
