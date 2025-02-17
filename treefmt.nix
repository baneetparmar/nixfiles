{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    shfmt.enable = true;
    yamlfmt.enable = true;
    mdsh.enable = true;
  };

  settings.global.excludes = [ "*.lock" ];
}
