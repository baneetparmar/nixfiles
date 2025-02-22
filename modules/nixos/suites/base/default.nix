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
  cfg = config.${namespace}.suites.base;

in
{
  options.${namespace}.suites.base = with types; {
    enable = mkBoolOpt false "Whether or not to basic system config.";
  };

  config = mkIf cfg.enable {

    ${namespace} = {
      system = {
        boot = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
        appimage = enabled;
        fonts = enabled;
      };
      nix = enabled;
      hardware = {
        audio = enabled;
        bluetooth = enabled;
        graphics = enabled;
      };
      apps = {
        neovim = enabled;
      };
    };
    environment.systemPackages = with pkgs; [

    ];
  };
}
