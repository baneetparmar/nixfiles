{
  lib,
  config,
  options,
  namespace,
  inputs,
  pkgs,
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
      cliphist
      gnome-bluetooth
      gobject-introspection
      gpu-screen-recorder
      grimblast
      hyprpicker
      hyprshot
      imagemagick
      nvtopPackages.full
      playerctl
      swappy
      swww
      tesseract
      tmux
      upower
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
          pygobject3
          pywayland
          pygobject-stubs

          buildPythonPackage
          rec {
            pname = "python-currencyconverter";
            version = "1.7";
            src = fetchPypi {
              inherit pname version;
              sha256 = "0v7pmmskhj1z8hx7mysjf88h3jszs6ap7pcvy5iw8qhw17w6m0hw";
            };
            doCheck = false;
          }
        ];
        extraBuildInputs = [
          pkgs.nur.repos.HeyImKyu.fabric-gray
          playerctl
          networkmanager
          networkmanager.dev
          vte
        ];
      })
      caffeine-ng
      tabler-icons
    ];
  };
}
