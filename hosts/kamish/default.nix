{
  inputs,
  pkgs,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    "${modulesPath}/profiles/minimal.nix"

    #optional
    ../common/optional/nixhelper.nix
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    wslConf.user.default = username;
    wslConf.network.hostname = "kamish";
  };

  hardware.opengl.enable = true;

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "24.05";
}
