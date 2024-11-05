{ ... }:
{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # BACKGROUND
      background {
          monitor =
          color = rgba(0,0,0, 1)
          blur_size = 1
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
}
