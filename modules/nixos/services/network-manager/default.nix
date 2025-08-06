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
    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      dnsovertls = "true";
      extraConfig = ''
        MulticastDNS=resolve
      '';
      llmnr = "true";
    };

    networking = {
      networkmanager.enable = true;
      networkmanager.dns = "systemd-resolved";

      nameservers = [
        "76.76.2.5#p2.freedns.controld.com"
        "76.76.10.5#p2.freedns.controld.com"
        "2606:1a40::5#p2.freedns.controld.com"
        "2606:1a40:1::5#p2.freedns.controld.com"
      ];
      firewall = {
        enable = false;
      };
    };
  };
}
