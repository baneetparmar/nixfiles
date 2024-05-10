{ pkgs, lib, hyprcursor-phinger, ... }: {
  imports = [ hyprcursor-phinger.homeManagerModules.default ];
  config = { programs.hyprcursor-phinger.enable = true; };
}
