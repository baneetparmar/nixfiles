{ pkgs, config, ... }:
{

  sops.secrets.passwd.neededForUsers = true;

  users.users.bane = {
    isNormalUser = true;
    hashedPassword = config.sops.secrets.passwd.path;
    description = "Baneet Parmar";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "libvirtd"
    ];

    shell = pkgs.fish;
  };
}
