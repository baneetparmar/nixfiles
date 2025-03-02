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
  cfg = config.${namespace}.development.webdev-env;
in
{
  options.${namespace}.development.webdev-env = with types; {
    enable = mkBoolOpt false "Whether or not to enable web development enviroment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
      yarn
      tailwindcss
      nodePackages.nodejs

      # LSP
      ccls
      sqls
      next-ls
      htmx-lsp
      tailwindcss-language-server
      vscode-langservers-extracted
    ];
  };

}
