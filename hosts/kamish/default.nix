{username, modulesPath, ...}:{
  imports = [
  "${modulesPath}/profiles/minimal.nix"

   #optional
   ../common/optional/nixhelper.nix
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
  };

  hardware.opengl.enable = true;
  }
