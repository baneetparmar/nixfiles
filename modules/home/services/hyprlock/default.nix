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
  cfg = config.${namespace}.services.hyprlock;
in
{
  options.${namespace}.services.hyprlock = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprlock.";
  };
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      extraConfig = ''
              # BACKGROUND
              background {
                  monitor =
                  path = ${
                    pkgs.fetchurl {
                      url = "https://user-images.githubusercontent.com/75974100/179296440-2ac2eab4-4742-477c-9776-ff1c790f1df1.png";
                      sha256 = "0b87cdscrslh9r7ajq625s675djmlxcsfyrp26h59706qf2sfcmj";
                    }
                  }
        #          color = rgba(0,0,0, 1)
                  blur_size = 7
                  blur_passes = 1
                  noise = 0.0117
                  contrast = 1.300
                  brightness = 0.800
                  vibrancy = 0.2100
                  vibrancy_darkness = 0.1
              }

              # GENERAL
              general {
                  no_fade_in = false
                  grace = 0
                  disable_loading_bar = true
              }

              # LOCK-ICON
              label {
                  monitor = 
                  text = <b>   </b>
                  color = rgba(255,255,255,0.6)
                  font_size = 60
                  font_family = FiraCode Nerd Font
                  position = 0, 250
                  halign = center 
                  valign = center 
                }

              # TIME
              label {
                  monitor =
                  text = cmd[update:1000] echo "<b><big> $(date +"%-H:%M") </big></b>"
                  color = rgba(255, 255, 255, 0.6)
                  font_size = 240
                  font_family = Noto Sans Regular 
                  position = 0, -150
                  halign = center 
                  valign = center 
              }

              # INPUT FIELD
              input-field {
                monitor =
                  size = 250, 50
                  outline_thickness = 2
                  dots_size = 0.3 
                  dots_spacing = 0.64
                  dots_center = true
                  outer_color = rgba(255, 255, 255, 0.8)
                  inner_color = rgba(0, 0, 0, 0.5)
                  font_color = rgb(200, 200, 200)
                  fade_on_empty = true
                  placeholder_text = <i><span foreground="##cdd6f4">Password...</span></i>
                  hide_input = false
                  position = 0, 150
                  halign = center
                  valign = bottom
              }
      '';
    };
  };
}
