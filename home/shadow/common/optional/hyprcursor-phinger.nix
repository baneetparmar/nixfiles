{ inputs, ... }:
{
  imports = [ inputs.hyprcursor-phinger.homeManagerModules.default ];
  programs.hyprcursor-phinger.enable = true;
}
