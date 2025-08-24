{
  lib,
  config,
  namespace,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.fish;
in
{
  options.${namespace}.tools.fish = with types; {
    enable = mkBoolOpt true "Whether or not to enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        up = "nh os boot";
        dup = "nh os boot -u";
        ls = "lsd";
      };

      shellInit = ''
        direnv hook fish | source
        zoxide init fish | source
      '';
      functions = {
        fish_greeting = "${pkgs.krabby}/bin/krabby random --no-title";
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };
    };
  };
}
