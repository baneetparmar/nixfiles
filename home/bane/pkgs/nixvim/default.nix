{ inputs, pkgs-unstable, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./plugins
    ./keymaps.nix
    ./options.nix
    ./colorscheme.nix
    ./globals.nix
  ];

  programs.nixvim.enable = true;

  programs.nixvim = {
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs-unstable; [
    bash-language-server
    yaml-language-server
    tailwindcss-language-server
    lua-language-server
    dockerfile-language-server-nodejs
    autotools-language-server
    pyright
    nil
    vim-language-server
    htmx-lsp
    nodePackages_latest.typescript-language-server
    svelte-language-server
  ];
}
