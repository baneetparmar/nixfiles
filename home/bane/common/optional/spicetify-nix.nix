{ pkgs, inputs, ... }:
let
  spicetifyPkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;
    theme = {
      name = "Galaxy";
      src = pkgs.spicetify-galaxy;
      requiredExtensions = [
        {
          filename = "theme.js";
          src = pkgs.spicetify-galaxy;
        }
      ];
      appendName = false;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };

    enabledExtensions = with spicetifyPkgs.extensions; [
      hidePodcasts
      adblock
    ];
  };
}
