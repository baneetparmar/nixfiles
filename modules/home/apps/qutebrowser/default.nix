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
  cfg = config.${namespace}.apps.qutebrowser;
in
{
  options.${namespace}.apps.qutebrowser = with types; {
    enable = mkBoolOpt false "Whether or not to enable Qute Browser.";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      package = pkgs.unstable.qutebrowser;
      loadAutoconfig = true;
      searchEngines = {
        DEFAULT = "https://www.google.co.in/search?q={}";
        nw = "https://wiki.nixos.org/index.php?search={}";
        rw = "https://{}";
        ur = "http://{}";
      };
      settings = {
        colors = {
          webpage = {
            darkmode.enabled = true;
            preferred_color_scheme = "dark";
          };
        };
        url = {
          default_page = "https://google.co.in";
          start_pages = "https://google.co.in";
        };
      };
    };
  };
}
