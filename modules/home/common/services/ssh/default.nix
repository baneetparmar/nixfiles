{
  lib,
  namespace,
  config,
  options,
  pkgs,
  system,
  username,
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
      enableDefaultConfig = false;

      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };

        "github.com" = {
          Host = "github.com";
          User = "git";
          IdentityFile = "${homeDir system username}/.ssh/github_personal";
        };
      };
    };
  };
}
