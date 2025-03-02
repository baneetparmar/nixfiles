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
  cfg = config.${namespace}.development.misc-env;
in
{
  options.${namespace}.development.misc-env = with types; {
    enable = mkBoolOpt false "Whether or not to enable more development tools and services.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [

      gcc
      glibc
      gnumake
      devenv

      nil
      sqls
      gopls
      jq-lsp
      marksman
      vim-language-server
      jdt-language-server
      yaml-language-server
      lua-language-server
      bash-language-server
      autotools-language-server
    ];
  };
}
