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
  cfg = config.${namespace}.services.mpvpaper;
in
{
  options.${namespace}.services.mpvpaper = with types; {
    enable = mkBoolOpt false "Whether or not to enable mpvpaper.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.mpvpaper ];
  };
}
