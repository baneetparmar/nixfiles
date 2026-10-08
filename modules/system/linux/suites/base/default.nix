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
    enable = mkBoolOpt false "Whether or not to base system config.";
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
      services = {
        plymouth = enabled;
        network-manager = enabled;
      };
      hardware = {
        audio = enabled;
        bluetooth = enabled;
        graphics = enabled;
      };
      apps = {
        neovim = {
          enable = true;
          setDefaultEditor = true;
        };
      };
      tools = {
        git = enabled;
      };
      user = {
        name = "shadow";
        fullName = "Baneet Parmar";
        email = "eraseableshadow@gmail.com";
        prompt-init = false;
        extraGroups = [
          "video"
          "audio"
          "docker"
          "networkmanager"
          "libvirtd"
          "gamemode"
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      git
    ];
  };
}
