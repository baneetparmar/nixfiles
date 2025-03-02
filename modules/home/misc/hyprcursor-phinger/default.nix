{
  lib,
  namespace,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.misc.hyprcursor-phinger;
in
{
  imports = [ inputs.hyprcursor-phinger.homeManagerModules.default ];
  options.${namespace}.misc.hyprcursor-phinger = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprcursors phinger cursors.";
  };
  config = mkIf cfg.enable {
    programs.hyprcursor-phinger.enable = true;
  };
}
