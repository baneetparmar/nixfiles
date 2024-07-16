{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        host = "github.com";
        user = "git";
        identityFile = [ "~/.ssh/github" ];
      };
    };
  };
}
