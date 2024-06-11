{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = "git_files";
      "<leader>ff" = "find_files";
    };
    extensions.fzf-native.enable = true;
  };
}
