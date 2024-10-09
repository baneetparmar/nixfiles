{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Baneet Parmar";
    userEmail = "baneetparmar7@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vim";
      commit.gpgsign = true;
      user.signingkey = "D5EA058BA8C6C7A9";
    };
  };
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-markdown-preview ];
    settings = {
      git_protocol = "ssh";
    };
  };
}
