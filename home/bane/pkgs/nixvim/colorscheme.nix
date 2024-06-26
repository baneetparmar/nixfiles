{ ... }:
{
  programs.nixvim.colorschemes = {
    tokyonight.enable = true;
    tokyonight.settings = {
      style = "storm";
      transparent = true;
      terminal_colors = true;
      hide_inactive_statusline = true;
    };
  };
}
