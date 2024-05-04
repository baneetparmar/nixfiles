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
      user.signingkey ="ECB96860AEE08FB3";
    };
  };
}

