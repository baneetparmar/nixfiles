{
  pkgs,
  config,
  options,
  namespace,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.neovim;
in
{
  options.${namespace}.apps.neovim = with types; {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
    setDefaultEditor = mkBoolOpt false "Whether or not to set neovim as default editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ inputs.nix-neovim.packages.${pkgs.system}.default ];
    environment.variables.EDITOR = mkIf cfg.setDefaultEditor "nvim";
  };
}
