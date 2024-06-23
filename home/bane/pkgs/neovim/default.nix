{ pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  loadConf = pluginName: "${builtins.readFile ./plugins/${pluginName}.lua}";
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      # ==== lsp and auto-completion ==== #
      luasnip
      nvim-cmp
      cmp-path
      cmp-buffer
      fidget-nvim
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      mason-nvim
      mason-lspconfig-nvim

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = loadConf "nvim-lspconfig";
      }

      # ==== eye candy ==== #
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = loadConf "nvim-treesitter";
      }

      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = loadConf "theme";
      }

      # ==== utils ===== #
      {
        plugin = telescope-nvim;
        type = "lua";
        config = loadConf "telescope";
      }

      {
        plugin = harpoon;
        type = "lua";
        config = loadConf "harpoon";
      }

      {
        plugin = trouble-nvim;
        type = "lua";
        config = loadConf "trouble-nvim";
      }

      {
        plugin = undotree;
        type = "lua";
        config = loadConf "undotree";
      }
    ];

    extraPackages = with pkgs; [ ];

    extraConfig = ''
      luafile /home/bane/.nixfiles/applications/neovim/options.lua
      luafile /home/bane/.nixfiles/applications/neovim/autocmds.lua
      luafile /home/bane/.nixfiles/applications/neovim/keymaps.lua
    '';
  };
}
