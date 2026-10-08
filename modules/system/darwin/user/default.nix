{
  lib,
  namespace,
  config,
  options,
  globals,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.user;
in
{
  options.${namespace}.user = with types; {
    name = mkOpt str globals.username "The name to use for the user account.";
    fullName = mkOpt str "Baneet Parmar" "The full name of the user.";
    email = mkOpt str "baneetparmar7@gmail.com" "The email of the user.";
  };

  config = {
    # macOS user accounts already exist from Setup Assistant - nix-darwin
    # doesn't create them. This just tells nix-darwin (and home-manager)
    # which account owns system-level, per-user defaults.
    system.primaryUser = cfg.name;
  };
}
