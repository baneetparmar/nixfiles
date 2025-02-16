{ pkgs, ... }:
{
  services.xserver.desktopManager.deepin.enable = true;
  services.deepin = {
    dde-api.enable = true;
    dde-daemon.enable = true;
    app-services.enable = true;
    deepin-anything.enable = true;
  };

  environment.deepin.excludePackages = with pkgs.deepin; [
    image-editor
    deepin-voice-note
    deepin-terminal
    deepin-reader
    deepin-music
    deepin-movie-reborn
    deepin-image-viewer
    deepin-draw
    deepin-album
  ];
}
