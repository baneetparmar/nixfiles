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
      gamescopeSession.enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      # steam breaks with these settings
      # extraPackages = with pkgs; [
      #   steamcmd
      #   steam-tui
      # ];
      # extraCompatPackages = with pkgs; [
      #   proton-ge-bin
      # ];
    };
    programs.steam.platformOptimizations.enable = true;
  };
}
