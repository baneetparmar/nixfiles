{
  lib,
  namespace,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];
  options.${namespace}.apps.spicetify = with types; {
    enable = mkBoolOpt false "Whether or not to enable Spicetify.";
  };
  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
      ];
      theme = spicePkgs.themes.defaultDynamic;
    };
  };
}
