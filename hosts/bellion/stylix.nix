{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = false;

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "Fantasque Sans Mono";
        package = pkgs.fantasque-sans-mono;
      };
      sansSerif = {
        name = "SF Pro Display";
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
      };
      serif = {
        name = "SF Pro Display";
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
      };

      sizes = {
        applications = 12;
        desktop = 11;
        popups = 10;
        terminal = 13;
      };
    };
    image = ../../wallpaper/static/revenant.png;
    homeManagerIntegration.followSystem = true;
  };
}
