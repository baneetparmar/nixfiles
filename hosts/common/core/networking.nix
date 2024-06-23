{ ... }:
{
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
    firewall.enable = false;
  };
}
