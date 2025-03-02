{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.development.rust-env;
in
{
  options.${namespace}.development.rust-env = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Rust development environment.";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bacon
      rustup
    ];
  };
}
