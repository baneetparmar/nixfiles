{ ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>pv";
      action = "vim.cmd.Ex";
      options.silent = true;
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.silent = true;
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.silent = true;
    }
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options.silent = true;
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options.silent = true;
    }
    {
      mode = "x";
      key = "<leader>y";
      action = "[[\"_dP]]";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>y";
      action = "[[\"+y]]";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = "[[\"+Y]]";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>d";
      action = "[[\"_d]]";
      options.silent = true;
    }
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-f>";
      action = "<cmd>silent !tmu neww tmu-sessionizer<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-f>";
      action = "vim.lsp.buf.format";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>cnext<CR>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>cprev<CR>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<cmd>lnext<CR>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>j";
      action = "<cmd>lprev<CR>zz";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>s";
      action = "[[:%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>]]";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>!chmod +x %<CR>\", { silent = true }";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ee";
      action = "oif err!= nil{<CR>}<Esc>0return err<Esc>";
      options.silent = true;
    }
  ];
}
