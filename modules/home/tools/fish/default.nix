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
  cfg = config.${namespace}.tools.fish;
  theme = "tokyoNightStorm";
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
        dup = "nh os boot";
        ls = "lsd";
      };

      shellInit = "\n      fish_config theme choose '${theme}'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
      functions = {
        fish_greeting = "${pkgs.krabby} random --no-title";
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };
    };
  };
}
