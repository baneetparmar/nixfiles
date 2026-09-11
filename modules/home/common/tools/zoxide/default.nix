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
  cfg = config.${namespace}.tools.zoxide;
in
{
  options.${namespace}.tools.zoxide = with types; {
    enable = mkBoolOpt false "Whether or not to enable zoxide.";
  };
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
