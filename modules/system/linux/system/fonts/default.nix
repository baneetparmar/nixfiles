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
      font-awesome
      fira-sans
      nerd-fonts.fira-code
      jetbrains-mono
      fantasque-sans-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
