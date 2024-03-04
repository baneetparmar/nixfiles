{ pkgs, config, flake, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Baneet Parmar";
    userEmail = "baneetparmar7@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "lvim";
      commit.gpgsign = true;
      user.signingkey ="B4B30DDF71713D91";
    };
  };
}

