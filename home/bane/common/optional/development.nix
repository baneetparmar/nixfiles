{ pkgs, ... }:
{
  home.packages =
    with pkgs.unstable;
    [
      vscode

      gcc
      glibc
      gnumake
      lldb_16

      bacon
      rustup

      pipx
      poetry
      python312
      python312Packages.pip

      bun
      yarn
      nodejs_22
      nodePackages.ijavascript

      devenv
    ]
    # language servers
    ++ (with pkgs.unstable; [
      jdt-language-server
      svelte-language-server
      yaml-language-server
      lua-language-server
      gopls
      vim-language-server
      htmx-lsp
      sqls
      nil
      typescript-language-server
      next-ls
      ruff-lsp
    ]);
}
