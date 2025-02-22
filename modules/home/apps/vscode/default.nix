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
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not enable VSCode.";
  };

  config = mkIf cfg.enable {
    programs.vscode.enable = true;
  };
}
