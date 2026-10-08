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
  cfg = config.${namespace}.tools.git;
in
{
  options.${namespace}.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user = {
          name = "Baneet Parmar";
          email = "baneetparmar7@gmail.com";
          signingkey = "6EA2F1751B672D69";
        };

        init.defaultBranch = "main";
        core.editor = "nvim";
        commit.gpgsign = true;
      };
    };

    home.packages = with pkgs; [
      lazygit
      gitmoji-cli
    ];
  };
}
