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
  cfg = config.${namespace}.tools.aria;
in
{
  options.${namespace}.tools.aria = with types; {
    enable = mkBoolOpt false "Whether or not to enable aria2.";
  };

  config = mkIf cfg.enable {
    programs.aria2 = {
      enable = true;
      settings = {
        dir = "${homeDir system username}/Downloads/";
        continue = true;
        max-concurrent-downloads = 1;
        max-connection-per-server = 16;
      };
    };
  };
}
