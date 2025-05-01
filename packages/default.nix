{ pkgs, ... }:
{
  google-play-books = pkgs.callPackage ./google-play-books { };
  vulkan-hdr-layer = pkgs.callPackage ./vulkan-hdr-layer { };
}
