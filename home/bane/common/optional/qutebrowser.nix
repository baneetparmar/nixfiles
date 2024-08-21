{ pkgs, ... }:
{
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

  };
}
