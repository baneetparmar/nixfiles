{ pkgs, ... }:
{
  google-play-books = pkgs.callPackage ./google-play-books { };
  vulkan-hdr-layer = pkgs.callPackage ./vulkan-hdr-layer { };
  tabler-icons = pkgs.callPackage ./tabler-icons { };
  space-isolation-grub-theme = pkgs.callPackage ./space-isolation-grub-theme { };
  space-isolation-plymouth-theme = pkgs.callPackage ./space-isolation-plymouth-theme { };
}
