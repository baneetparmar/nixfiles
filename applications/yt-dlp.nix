{ ... }: {
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
}
