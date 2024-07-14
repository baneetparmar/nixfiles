{ ... }:
{
  imports = [
    ./locale.nix
    ./nixconf.nix
    ./networking.nix

    ./boot
    ./hardware
  ];
}
