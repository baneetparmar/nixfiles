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
  cfg = config.${namespace}.system.fonts;
in
{
  options.${namespace}.system.fonts = with types; {
    enable = mkBoolOpt true "Whether or not to enable common fonts.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains-mono
      font-awesome
      fira-code
      nerd-fonts.fira-code
      fantasque-sans-mono
      noto-fonts-color-emoji
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono
    ];
  };
}
