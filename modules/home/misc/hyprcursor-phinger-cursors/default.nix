{
  pkgs,
  config,
  namespace,
  options,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.misc.hyprcursor-phinger-cursors;
in
{
  imports = [ inputs.hyprcursor-phinger.homeManagerModules.default ];
  options.${namespace}.misc.hyprcursor-phinger-cursors = with types; {
    enable = mkBoolOpt false "Whether to enable hyprcursor phinger-cursors or not.";
  };

  config = mkIf cfg.enable {
    programs.hyprcursor-phinger.enable = true;
  };

}
