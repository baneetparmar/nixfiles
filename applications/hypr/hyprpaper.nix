{ builtins, ... }:
let wall = "~/Pictures/Wallpapers/1334626.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wall;
      wallpaper = [
        "DP-2,${wall}"
      ];
    };
  };
}
