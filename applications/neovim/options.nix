{ ... }:

{
  programs.nixvim = {
    colorschemes.onedark.enable = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;
    clipboard.providers.wl-copy.enable = true;
    opts = {
      updatetime = 100;

      autoindent = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = false;
      clipboard = "unnamedplus";

      number = true;
      relativenumber = true;
      splitbelow = true;
      splitright = true;
      scrolloff = 4;

      ignorecase = true;
      incsearch = true;
      smartcase = true;
      wildmode = "list:longest";

      swapfile = false;
      undofile = true;
    };
  };
}
