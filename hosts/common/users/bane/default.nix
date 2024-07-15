{ pkgs, config, ... }:
  let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in
{

  sops.secrets.passwd.neededForUsers = true;

  users.users.bane = {
    isNormalUser = true;
    extraGroups = [
      "wheel"] ++ ifTheyExist [
      "video"
      "audio"
      "docker"
      "networkmanager"
      "libvirtd"
    ];
    
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.git.enable = true;
}

