{ builtins, ... }:
let
  wall = "~/Pictures/Wallpapers/1251766.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = wall;
      wallpaper = [ "DP-2,${wall}" ];
    };
  };
}
