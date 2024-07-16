{ pkgs, inputs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = null;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      libappindicator
      libadwaita
    ];
  };
  home.packages = with pkgs; [swappy sassc dart-sass inotify-tools brightnessctl pavucontrol libadwaita];
}
