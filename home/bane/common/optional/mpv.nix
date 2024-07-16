{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ autoload ];
    config = {
      sub-file-paths = "$HOME/Videos/.subtitles/";
    };
  };
}
