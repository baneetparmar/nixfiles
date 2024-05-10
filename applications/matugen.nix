{ pkgs, lib, matugen, ... }:

{
  imports = [ matugen.nixosModules.default ];
  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
  };
}
