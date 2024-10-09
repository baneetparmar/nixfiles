{ username, ... }:
{

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 30d --keep 3";
    flake = "/home/${username}/.nixfiles";
  };
}
