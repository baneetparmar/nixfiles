{ ... }:

{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
    };
    cmp-buffer.enable = true;
    cmp-emoji.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
  };
}
