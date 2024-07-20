{ outputs, ... }:
{
  imports = [
    ./locale.nix
    ./nixconf.nix
    ./networking.nix

    ./hardware
  ];

  programs.dconf.enable = true;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
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
}
