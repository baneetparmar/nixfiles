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
      userName = "Baneet Parmar";
      userEmail = "baneetparmar7@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        commit.gpgsign = true;
        user.signingkey = "595FF4E242BD61CE";
      };
    };
    home.packages = with pkgs; [
      lazygit
      gitmoji-cli
    ];
  };
}
