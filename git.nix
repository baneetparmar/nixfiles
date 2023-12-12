{ pkgs, config, flake, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Baneet Parmar";
    userEmail = "eraseableshadow@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "lvim";
      commit.gpgsign = true;
      user.signingkey = "D62277961A380B36";
    };
  };
}

