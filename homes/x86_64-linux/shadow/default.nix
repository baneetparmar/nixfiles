{
  lib,
  pkgs,
  config,
  osConfig ? { },
  format ? "unknown",
  namespace,
  ...
}:
with lib.${namespace};
{
  snow = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };

    cli-apps = {
      home-manager = enabled;
    };

    archetypes = {
      workstation = enabled;
    };

  };

  home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "24.11";
}
