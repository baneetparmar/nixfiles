{ ... }:
{
  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true; # fix windows sync problem
  };

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
  
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
}
