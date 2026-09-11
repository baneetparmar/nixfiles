{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.base;
in
{
  options.${namespace}.suites.base = with types; {
    enable = mkBoolOpt false "Whether or not to enable the base darwin config.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      nix = enabled;
      apps.neovim = {
        enable = true;
        setDefaultEditor = true;
      };
    };

    environment.systemPackages = with pkgs; [
      git
      curl
      wget
    ];
  };
}
