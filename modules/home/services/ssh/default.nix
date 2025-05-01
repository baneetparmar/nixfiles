{
  lib,
  namespace,
  config,
  options,
  pkgs,
  globals,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.ssh;
in
{
  options.${namespace}.services.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to enable ssh.";
  };
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";

      matchBlocks = {
        "github.com" = {
          host = "github.com";
          user = "git";
          identityFile = [ "/home/${globals.username}/.ssh/github_personal" ];
        };
      };
    };
  };
}
