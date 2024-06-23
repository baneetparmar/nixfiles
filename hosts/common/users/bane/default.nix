{ pkgs, ... }:
{
  users.users.bane = {
    isNormalUser = true;
    password = "IamBatman";
    description = "Baneet Parmar";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ];

    shell = pkgs.fish;
  };

  # TODO: enable sops
  # users.mutableUsers = false;
}
