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
    enable = mkBoolOpt false "Whether or not to enable Visual Studio Code.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.deafault.extensions = with pkgs.vscode-extensions; [
        enkia.tokyo-night # theme
      ];
    };
  };
}
