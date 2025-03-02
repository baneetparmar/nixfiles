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
  cfg = config.${namespace}.tools.ytdlp;
in
{

  options.${namespace}.tools.ytdlp = with types; {
    enable = mkBoolOpt false "Whether or not to enable yt-dlp.";
  };

  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
      extraConfig = ''
        --no-overwrites
        --no-playlist
        --embed-metadata
        --format "bestvideo+bestaudio"
        --output '%(track_number,playlist_autonumber)d-%(track,title)s.%(ext)s'
        --embed-thumbnail
        --add-metadata
        --no-update
        --paths "~/Videos/"
      '';
    };
  };
}
