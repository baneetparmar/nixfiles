{ pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    # theme = "DcMarvel";
    # themePackages = [ pkgs.dc-marvel-plymouth-theme ];
  };
}
