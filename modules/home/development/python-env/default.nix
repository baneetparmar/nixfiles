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
  cfg = config.${namespace}.development.python-env;
in
{
  options.${namespace}.development.python-env = with types; {
    enable = mkBoolOpt false "Whether or not to enable python development environment.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pipx
      poetry
      python312
      python312Packages.pip

      ruff
      ruff-lsp
      python312Packages.python-lsp-server
    ];
  };
}
