{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    qt6.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5.qtwayland

    phinger-cursors
    graphite-gtk-theme
    graphite-kde-theme

    (google-fonts.override {
      fonts = [
        "Noto Sans"
        "Noto Serif"
        "Open Sans"
        "Jetbrains Mono"
        "Fira Sans"
      ];
    })
    font-awesome
    fira-code-nerdfont
    fantasque-sans-mono
    noto-fonts-color-emoji
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono
  ];

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
        themeVariants = [ "purple" ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "compact" ];
        tweaks = [
          "normal"
          "rimless"
        ];
      };
      name = "Graphite-purple-Dark-compact";
    };
    iconTheme = {
      package = pkgs.kora-icon-theme;
      name = "kora";
    };
  };
}
