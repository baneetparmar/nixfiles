{
  lib,
  config,
  options,
  namespace,
  globals,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.misc.virtual-machine;
in
{
  options.${namespace}.misc.virtual-machine = with types; {
    enable = mkBoolOpt false "Whether or not to enable support for Virtual Machines via Qemu & Virt-Manager .";
  };
  config = mkIf cfg.enable {
    programs.dconf.enable = true;
    users.users.${globals.username}.extraGroups = [ "libvirtd" ];
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
