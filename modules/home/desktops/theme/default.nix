{
  lib,
  namespace,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktops.theme;
in
{
  options.${namespace}.desktops.theme = with types; {
    enable = mkBoolOpt false "Whether or not to set default theme configuration.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum

      phinger-cursors
      fluent-gtk-theme

      fira-sans
      nerd-fonts.fira-code
      fantasque-sans-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "Fanstasque Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "phinger-cursors-dark";
      size = 24;
      package = pkgs.phinger-cursors;
      x11.enable = true;
      x11.defaultCursor = "phinger-cursors-dark";
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    gtk = {
      enable = true;
      theme = {
        name = "fluent-round-grey-Dark-compact";
        package = pkgs.fluent-gtk-theme.override {
          themeVariants = [ "grey" ];
          colorVariants = [ "dark" ];
          sizeVariants = [ "compact" ];
          tweaks = [
            "float"
            "round"
            "noborder"
          ];
        };
      };
      iconTheme = {
        package = pkgs.kora-icon-theme;
        name = "kora";
      };
      cursorTheme = {
        name = "phinger-cursors-dark";
        package = pkgs.phinger-cursors;
        size = 24;
      };
    };
  };
}
