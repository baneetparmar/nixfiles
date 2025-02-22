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
  cfg = config.${namespace}.services.clipse;
in
{

  options.${namespace}.services.clipse = with types; {
    enable = mkBoolOpt false "Whether or not to enable clipse clipboard manager.";
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.clipse ];
  };
}
