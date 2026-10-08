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
  cfg = config.${namespace}.tools.fzf;
in
{
  options.${namespace}.tools.fzf = with types; {
    enable = mkBoolOpt false "Whether or not to enable fuzzy finder.";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
