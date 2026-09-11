{
  lib,
  pkgs,
  inputs,
  globals,
  namespace,
  username,
  system,
  config,
  ...
}:
with lib;
with lib.${namespace};

{
  imports = [
    ../../modules/home/import.nix
  ];

  home = {
    username = lib.mkForce username;
    homeDirectory = lib.mkForce (homeDir system username);
    stateVersion = globals.stateVersion;
    sessionVariables = {
      FLAKE = "${homeDir system username}/.nixfiles";
    };
    sessionPath = [
      "$HOME/.local/bin/"
      "$HOME/.cargo/bin/"
    ];
  };

  programs.home-manager.enable = true;

  ${namespace} = {
    services = {
      ssh = enabled;
    };
    dev = {
      core = enabled;
    };
    tools = {
      aria = enabled;
      bat = enabled;
      direnv = enabled;
      fish = enabled;
      fzf = enabled;
      gh = enabled;
      git = enabled;
      gpg = enabled;
      nh = enabled;
      starship = enabled;
      tealdeer = enabled;
      ytdlp = enabled;
      zoxide = enabled;
    };

  };

  home.packages = with pkgs; [
    ripgrep
    fd
    sd
    wget
    ncdu
    lsd
    btop
    glow
  ];
}
