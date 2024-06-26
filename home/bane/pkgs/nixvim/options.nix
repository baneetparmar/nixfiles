{ ... }:
{
  programs.nixvim.opts = {
    ignorecase = true;
    hidden = true;
    ttimeoutlen = 5;
    shortmess = "atI";
    wrap = false;
    backup = false;
    writebackup = false;
    errorbells = false;
    swapfile = false;
    showmode = false;
    laststatus = 3;
    pumheight = 8;
    completeopt = "menuone,noselect";

    viminfo = "";
    viminfofile = "NONE";

    cursorline = true;
    relativenumber = true;
    number = true;

    mouse = "a";

    clipboard = "unnamedplus";

    smartindent = true;
    tabstop = 2;
    shiftwidth = 2;
    shiftround = true;
    expandtab = true;
    scrolloff = 10;

    undofile = true;
  };
}
