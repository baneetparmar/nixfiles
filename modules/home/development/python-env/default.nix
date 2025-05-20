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
      python313
      python313Packages.pip

      ruff
      python313Packages.python-lsp-ruff
      python313Packages.python-lsp-server
    ];
  };
}
