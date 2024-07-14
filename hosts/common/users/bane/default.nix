{ pkgs, config, ... }:
{

  sops.secrets.passwd.neededForUsers = true;

  users.users.bane = {
    isNormalUser = true;
    description = "Baneet Parmar";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "libvirtd"
    ];
    
    initialHashedPassword = "$y$j9T$TdmhtW12jXfBFKh1DECXY0$kEjsYCp0KeLZvbnXUCPhft/cMOp/IyxRAK2pGagH.E7";
    shell = pkgs.fish;
  };
}

