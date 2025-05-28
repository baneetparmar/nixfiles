{
  lib,
  namespace,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.misc.ax-shell;
in
{
  options.${namespace}.misc.ax-shell = with types; {
    enable = mkBoolOpt false "Whether or not to enable Axenide's Ax-Shell.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cava
      matugen
      gnome-bluetooth
      gobject-introspection
      gpu-screen-recorder
      grimblast
      hyprshot
      imagemagick
      nvtopPackages.full
      playerctl
      swappy
      swww
      tesseract
      tmux
      webp-pixbuf-loader
      wl-clipboard
      wlinhibit
      pkgs.nur.repos.HeyImKyu.fabric-cli
      (pkgs.nur.repos.HeyImKyu.run-widget.override {
        extraPythonPackages = with python3Packages; [
          toml
          ijson
          numpy
          pillow
          psutil
          chardet
          thefuzz
          requests
          watchdog
          setproctitle

          pyjson5
          pytomlpp
        ];
        extraBuildInputs = [
          pkgs.nur.repos.HeyImKyu.fabric-gray
          playerctl
          networkmanager
          networkmanager.dev
        ];
      })
      typstPackages.use-tabler-icons
    ];
  };
}
