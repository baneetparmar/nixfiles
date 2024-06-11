{ ... }:

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      indent = true;
      nixGrammars = true;
    };
    treesitter-context = {
      enable = true;
      settings = { max_lines = 4; };
    };
    rainbow-delimiters.enable = true;
  };
}
