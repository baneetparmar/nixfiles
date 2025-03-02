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
        dir = "/home/${globals.username}/Downloads/";
        continue = true;
        max-concurrent-downloads = 1;
        max-connection-per-server = 16;
      };
    };
  };
}
