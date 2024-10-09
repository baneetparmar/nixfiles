{
  inputs,
  outputs,
  pkgs,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common/core/locale.nix
    ../common/core/nixconf.nix

    #optional
    ../common/optional/nixhelper.nix

    #user
    "../common/users/${username}"
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    wslConf.user.default = username;
    wslConf.network.hostname = "kamish";
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
    hostPlatform = "x86_64-linux";
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
      ];
    };
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "24.05";
}
