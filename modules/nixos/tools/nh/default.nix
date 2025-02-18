{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.nh;
in
{
  options.${namespace}.tools.nh = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-helper utility.";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 30d --keep 3";
      flake = "$HOME/.nixfiles";
    };
  };
}
