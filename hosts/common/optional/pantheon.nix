{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = false;
      greeters.pantheon.enable = false;
    };
    desktopManager.pantheon = {
      enable = true;
      extraWingpanelIndicators = with pkgs; [
        wingpanel-indicator-ayatana
      ];
    };
  };

  services.pantheon.apps.enable = false;

  # App indicator
  # - https://github.com/NixOS/nixpkgs/issues/144045#issuecomment-992487775
  environment = {
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      indicator-application-gtk3
    ];
  };

  systemd.user.services.indicatorapp = {
    description = "indicator-application-gtk3";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.indicator-application-gtk3}/libexec/indicator-application/indicator-application-service";
    };
  };

}
