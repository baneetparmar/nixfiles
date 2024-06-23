{ lib, pkgs, ... }:
{
  imports = [
    ../common/core
    ../common/users/bane
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  networking.hostName = "bellion";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.displayManager.defaultSession = "hyprland";

  services.xserver.desktopManager.gnome.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-gtk # For both
      pkgs.xdg-desktop-portal-hyprland # For Hyprland
      pkgs.xdg-desktop-portal-gnome # For GNOME
      pkgs.libsForQt5.xdg-desktop-portal-kde # for KDE
    ];
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
  };

  security.rtkit.enable = true;

  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;

  programs.hyprland.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    extraPackages = with pkgs; [
      gamescope
      steamcmd
      steam-tui
    ];
  };
  programs.firefox.enable = true;

  programs.kdeconnect.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    lunarvim
  ];

  virtualisation.waydroid.enable = true;

  system.stateVersion = "24.05";
}
