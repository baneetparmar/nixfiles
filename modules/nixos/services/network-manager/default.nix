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
  cfg = config.${namespace}.services.network-manager;
in
{
  options.${namespace}.services.network-manager = with types; {
    enable = mkBoolOpt false "Whether or not to enable NetworkManager.";
  };

  config = mkIf cfg.enable {
    networking = {
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      networkmanager.enable = true;
      networkmanager.insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
        ];
        allowedUDPPortRanges = [
          {
            from = 3000;
            to = 3010;
          }
          {
            from = 5500;
            to = 5510;
          }
          {
            from = 5000;
            to = 5010;
          }
        ];
      };
    };
  };
}
