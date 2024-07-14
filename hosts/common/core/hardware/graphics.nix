{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport.enable = true;
    driSupport32Bit.enable = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };
}
