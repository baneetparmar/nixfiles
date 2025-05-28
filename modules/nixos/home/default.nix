{
  options,
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  namespace,
  globals,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.home;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  options.${namespace}.home = with types; {
    enable = mkBoolOpt true "Whether or not to enable home-manager. Enabled by default.";
  };

  config = {
    home-manager = {
      users.${globals.username} =
        import ../../../home/${globals.username}/${config.networking.hostName}.nix;
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          globals
          namespace
          ;
      };
    };
  };
}
