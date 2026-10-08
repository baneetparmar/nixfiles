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

    # Link SSH keys from secrets
    home.file.".ssh/github_personal".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/github.com/ssh/private";

    home.file.".ssh/github_personal.pub".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/github.com/ssh/public";

    home.file.".ssh/pesto".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/pesto.dev/ssh/private";

    home.file.".ssh/pesto.pub".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/pesto.dev/ssh/public";

    home.file.".ssh/google".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/google.google.com/ssh/private";

    home.file.".ssh/google.pub".source =
      config.lib.file.mkOutOfStoreSymlink
        "/run/secrets/google.google.com/ssh/public";
  };

}
