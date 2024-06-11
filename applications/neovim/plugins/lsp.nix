{ ... }:

{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    lsp-lines = {
      enable = true;
      currentLine = true;
    };
    rust-tools.enable = true;
  };
}
