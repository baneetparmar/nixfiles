{
  pkgs,
  config,
  options,
  namespace,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.ags;
in
{
  options.${namespace}.apps.ags = with types; {
    enable = mkBoolOpt false "Whether or not to enable AGS.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.default
    ];
  };
}
