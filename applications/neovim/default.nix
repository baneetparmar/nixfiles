{ inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ./keymaps.nix ./plugins ./options.nix ];


  home.shellAliases.nv = "nvim";

  programs.nixvim.enable = true;

}
