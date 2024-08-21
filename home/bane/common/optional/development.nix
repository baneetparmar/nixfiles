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
      tailwindcss
      nodePackages.ijavascript

      devenv
    ]
    # language servers
    ++ (with pkgs.unstable; [
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

    ]);
}
