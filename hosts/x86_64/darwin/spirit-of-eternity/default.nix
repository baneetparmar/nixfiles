{
  lib,
  pkgs,
  config,
  inputs,
  namespace,
  globals,
  ...
}:

{
  imports = [
    ./sops.nix

    ../../../../modules/system/import.nix
  ];

  config.${namespace} = with lib.custom; {
    suites.base = enabled;
  };

  config = {
    networking.hostName = "spirit-of-eternity";
    networking.computerName = "spirit-of-eternity";
    nixpkgs.config.allowDeprecatedX86_64Darwin = true;
    programs.fish.enable = true;
    users.users."baneetparmar" = {
      uid = 501;
      shell = pkgs.fish;

    };

    system.stateVersion = 5;
  };
}
