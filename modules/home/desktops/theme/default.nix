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
    enable = mkBoolOpt false "Whether or not to enable standard theme configs.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum

      phinger-cursors
      graphite-gtk-theme
      graphite-kde-theme

      jetbrains-mono
      font-awesome
      fira-code
      nerd-fonts.fira-code
      fantasque-sans-mono
      noto-fonts-color-emoji
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "sf pro" ];
        serif = [ "sf pro" ];
        monospace = [ "Fanstasque Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
      style.package = pkgs.graphite-kde-theme;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.graphite-gtk-theme.override {
          themeVariants = [ "blue" ];
          colorVariants = [ "dark" ];
          sizeVariants = [ "compact" ];
          tweaks = [
            "normal"
            "rimless"
          ];
        };
        name = "Graphite-blue-Dark-compact";
      };
      iconTheme = {
        package = pkgs.kora-icon-theme;
        name = "kora";
      };
    };
  };
}
