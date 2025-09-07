{
  lib,
  config,
  namespace,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.dev.core;
in
{
  options.${namespace}.dev.core = with types; {
    enable = mkBoolOpt false "Whether or not to enable core developer enviroment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      glibc
      gnumake
      python3Full
      rustup
    ];
  };

}
