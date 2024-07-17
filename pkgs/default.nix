{ pkgs, ... }:
{
  cyberre-grub-theme = pkgs.callPackage ./cyberre-grub-theme { };
  spicetify-galaxy = pkgs.callPackage ./spicetify-galaxy { };
  notion-desktop = pkgs.callPackage ./notion-desktop { };
}
