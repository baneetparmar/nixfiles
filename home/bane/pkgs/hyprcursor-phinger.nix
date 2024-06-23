{ pkgs
, lib
, inputs
, ...
}:
{
  imports = [ inputs.hyprcursor-phinger.homeManagerModules.default ];
  config = {
    programs.hyprcursor-phinger.enable = true;
  };
}
