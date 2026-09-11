{
  lib,
  pkgs,
  config,
  inputs,
  namespace,
  globals,
  ...
}:

{
  imports = [
    ./sops.nix
    ./disko.nix
    ./hardware-configuration.nix

    ../../modules/system/import.nix
    inputs.nur.modules.nixos.default

    # required for using chaotic-nyx on stable channel
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];

  config.${namespace} = with lib.custom; {
    archetypes.gaming = enabled;
    misc = {
      nix-ld = enabled;
    };
  };

  config = {
    networking.hostName = "the-world-engine";

    boot = {
      loader.grub = {
        theme = "${pkgs.space-isolation-grub-theme}";
        splashImage = "${pkgs.space-isolation-grub-theme}/background.jpg";
      };
    };

    services.xserver.enable = true;
    programs.xwayland.enable = true;

    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

    #https://github.com/chaotic-cx/nyx/issues/1158
    system.modulesTree = [ (lib.getOutput "modules" pkgs.linuxPackages_cachyos.kernel) ]; # !!!!!!!!

    services.xserver.videoDrivers = [ "amdgpu" ];

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

    fonts.fontconfig = {
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };
      hinting = {
        enable = true;
        autohint = true;
      };
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Fanstasque Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    environment.systemPackages = with pkgs; [
      vulkan-hdr-layer-kwin6
      where-is-my-sddm-theme
      gtk3
    ];

    # glib schemas fix
    environment.variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    services.preload.enable = true;

    system.stateVersion = globals.stateVersion;
  };

}
