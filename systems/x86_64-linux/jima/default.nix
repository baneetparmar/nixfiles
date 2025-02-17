##########################################################################
#                                                                        #
#  Jima - The Elite Knight also my WSL system (if i ever used one again) #
#  system specification - forgot about them                              #
#                                                                        #
##########################################################################

{
  pkgs,
  inputs,
  outputs,
  namespace,
  ...
}:
{
  imports = [ ];

  wsl = {
    enable = true;
    defaultUser = "shadow";
    wslConf.user.default = "shadow";
    wslConf.network.hostname = "jima";
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
      ];
    };
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "24.11";
}
