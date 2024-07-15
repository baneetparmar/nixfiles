{ ... }:
{
  imports = [
    ./locale.nix
    ./nixconf.nix
    ./networking.nix

    ./boot
    ./hardware
  ];

  programs.dconf.enable = true;
  nixpkgs.config.allowUnfree = true;
}
