{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [ qt6.qt5compat ];
    settings = {
      Theme = {
        CursorTheme = "phinger-cursors-dark";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
    phinger-cursors
  ];
}
