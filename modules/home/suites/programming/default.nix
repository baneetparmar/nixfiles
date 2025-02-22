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
  cfg = config.${namespace}.suites.programming;
in
{
  options.${namespace}.suites.programming = with types; {
    enable = mkBoolOpt false "Whether or not to enable common programming apps and settings.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      glibc
      gnumake

      bacon
      rustup

      pipx
      poetry
      python312
      python312Packages.pip

      bun
      yarn
      tailwindcss
      nodePackages.nodejs

      devenv

      # language servers
      nil
      ccls
      ruff
      sqls
      gopls
      jq-lsp
      next-ls
      htmx-lsp
      marksman
      ruff-lsp
      vim-language-server
      jdt-language-server
      yaml-language-server
      lua-language-server
      bash-language-server
      svelte-language-server
      autotools-language-server
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
      python312Packages.python-lsp-server

    ];
  };
}
