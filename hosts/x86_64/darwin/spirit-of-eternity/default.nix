{ lib, pkgs,config, inputs, namespace, globals, ... }:

{
  imports = [
    ./sops.nix
    ../../../../modules/nixos/nix/default.nix
  ];


  config.${namespace} = with lib.custom; {
    nix = enabled;
  };

  config = {
  system.stateVersion = 5;
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];
  };

}