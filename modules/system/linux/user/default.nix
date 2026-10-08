{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.user;

  # Filters valid user-groups
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  options.${namespace}.user = with types; {
    name = mkOpt str "shadow" "The name to use for the user account.";
    fullName = mkOpt str "Baneet Parmar" "The full name of the user.";
    email = mkOpt str "eraseableshadow@gmail.com" "The email of the user.";
    initialPassword =
      mkOpt str "changeMePls"
        "The initial password to use when the user is first created.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    programs.fish.enable = true;

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;
      extraGroups = [ "wheel" ] ++ ifTheyExist cfg.extraGroups;

    };
  };

}
