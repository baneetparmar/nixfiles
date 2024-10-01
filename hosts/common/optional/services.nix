{ pkgs, ... }:
{
  services.passSecretService.enable = true;
  services.hardware.openrgb.enable = true;
}
