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
  cfg = config.${namespace}.dev.core;
in
{
  options.${namespace}.dev.core = with types; {
    enable = mkBoolOpt false "Whether or not to enable core developer enviroment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      glibc
      gnumake
      bun
      yarn
      tailwindcss
      nodePackages.nodejs

      # LSP
      # ccls
      # sqls
      # next-ls
      # htmx-lsp
      # tailwindcss-language-server
      # vscode-langservers-extracted
      # nil
      # sqls
      # gopls
      # jq-lsp
      # marksman
      # vim-language-server
      # jdt-language-server
      # yaml-language-server
      # lua-language-server
      # bash-language-server
      # autotools-language-server
      # ruff
      # python313Packages.python-lsp-ruff
      # python313Packages.python-lsp-server
    ];
  };

}
