{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common/core
    ../common/users/bane
    ./hardware-configuration.nix
    ./sops.nix
    # ./disko.nix
  ];

  networking.hostName = "bellion";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  xdg.portal = {
    enable = true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
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
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
      if (subject.local) return "yes";
      });
    '';
  };

  programs.fish.enable = true;

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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 30d --keep 3";
    flake = "/home/bane/.nixfiles";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    hyprnome
    gnome.nautilus
    gnome.file-roller
    inputs.nx.packages.${system}.default
  ];

  environment.shellAliases = {
    nx = "nvim";
  };

  virtualisation.waydroid.enable = true;

  programs.dconf.enable = true;

  system.stateVersion = "24.05";
}
