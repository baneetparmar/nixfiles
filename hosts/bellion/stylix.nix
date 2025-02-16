{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;

    polarity = "dark";

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
        name = "SF Pro Regular ";
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
      };
      serif = {
        name = "SF Pro Regular";
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 9;
        terminal = 13;
      };
    };
    homeManagerIntegration.followSystem = true;

    image = pkgs.fetchurl {
      url = "https://user-images.githubusercontent.com/75974100/179296440-2ac2eab4-4742-477c-9776-ff1c790f1df1.png";
      sha256 = "0b87cdscrslh9r7ajq625s675djmlxcsfyrp26h59706qf2sfcmj";
    };

  };

  # disabled ttargets
  home-manager.sharedModules = [
    {
      stylix.targets = {
        rofi.enable = false;
        hyprlock.enable = false;
      };
    }
  ];
}
