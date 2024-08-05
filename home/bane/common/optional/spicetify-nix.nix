{ inputs, pkgs, ... }:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
      ];
      theme = {
        name = "spicetify-galaxy";
        src = pkgs.fetchFromGitHub {
          owner = "harbassan";
          repo = "spicetify-galaxy";
          rev = "2b2e33c02c5adffd6737e4a93c261e961fad8eca";
          hash = "sha256-cerdcfmPuKMnFCJg+wmOZ7bwesheWWWVckVxWrCn+48=";
        };
        injectCss = true;
        injectThemeJs = true;
        replaceColors = true;
        sidebarConfig = true;
        homeConfig = true;
        overwriteAssets = false;
        additonalCss = "";
      };
    };
}
