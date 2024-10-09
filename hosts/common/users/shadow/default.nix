{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  users.users.shadow = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" ]
      ++ ifTheyExist [
        "video"
        "audio"
        "docker"
        "networkmanager"
        "libvirtd"
        "gamemode"
      ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.git.enable = true;
}
