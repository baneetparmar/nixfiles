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
        "8.8.8.8"
        "8.8.4.4"
      ];
      networkmanager.enable = true;
      networkmanager.insertNameservers = [
        "8.8.8.8"
        "8.8.4.4"
      ];
      firewall = {
        enable = false;
        # allowedTCPPorts = [
        #   80
        #   443
        # ];
        # allowedUDPPortRanges = [
        #   {
        #     from = 3000;
        #     to = 3010;
        #   }
        #   {
        #     from = 5500;
        #     to = 5510;
        #   }
        #   {
        #     from = 5000;
        #     to = 5010;
        #   }
        #   {
        #     from = 50000;
        #     to = 55000;
        #   }
        # ];
      };
    };
  };
}
