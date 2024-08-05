{ pkgs, ... }:
{
  cyberre-grub-theme = pkgs.callPackage ./cyberre-grub-theme { };
  spicetify-galaxy = pkgs.callPackage ./spicetify-galaxy { };
  notion-desktop = pkgs.callPackage ./notion-desktop { };
  oneui4-icons-theme = pkgs.callPackage ./oneui4-icons-theme { };
  wora-music-player = pkgs.callPackage ./wora-music-player { };
  google-play-books = pkgs.callPackage ./google-play-books { };
}
