{
  lib,
  config,
  namespace,
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
      llmnr = "true";
      settings = {
        Resolve.MulticastDNS = "resolve";
      };
    };

    networking = {
      networkmanager.enable = true;
      networkmanager.dns = "systemd-resolved";

      nameservers = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
      firewall = {
        enable = false;
      };
    };
  };
}
