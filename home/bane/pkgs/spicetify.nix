{ pkgs
, pkgs-unstable
, lib
, inputs
, ...
}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  hazy = pkgs.fetchgit {
    url = "https://github.com/Astromations/Hazy.git";
    rev = "0d45831a31b0c72e1d3ab8be501479e196a709d7";
    sha256 = "03y25wv0pi7h88iw5d3i61nmmi4p1hw4z9xgy24zqzjik3dzzpnj";
    leaveDotGit = false;
    deepClone = false;
    fetchSubmodules = false;
  };
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs-unstable.spotify;
    theme = {
      name = "Hazy";
      src = hazy;
      requiredExtensions = [
        {
          filename = "hazy.js";
          src = hazy;
        }
      ];
      appendName = false;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };

    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      adblock
    ];
  };
}
