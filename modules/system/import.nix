{ lib, system, ... }:
{
  imports = lib.custom.autoImport {
    inherit system;
    dir = ./.;
  };
}
