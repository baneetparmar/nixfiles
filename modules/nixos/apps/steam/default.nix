{
  pkgs,
  config,
  namespace,
  options,
  inputs,
  lib,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.steam;
in
{
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];

  options.${namespace}.apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable steam.";
  };

  config = mkIf cfg.enable {

    programs.steam = {
      enable = true;
      extest.enable = true;

      # TODO: fix steam breaking
      # extraPackages = with pkgs.legacy; [
      #   steamcmd
      #   steam-tui
      # ];
      # package = pkgs.legacy.steam;
      # extraCompatPackages = with pkgs.unstable; [
      #   proton-ge-bin
      # ];
    };
    programs.steam.platformOptimizations.enable = true;
  };
}
