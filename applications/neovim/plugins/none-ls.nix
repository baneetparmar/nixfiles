{ ... }:

{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources = {
      #   diagnostics = {
      #     
      #   }
      formatting = {
        nixfmt.enable = true;
        markdownlint.enable = true;
        shfmt.enable = true;
      };
    };
  };
}
