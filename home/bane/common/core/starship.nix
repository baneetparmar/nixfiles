{ ... }:
{
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship.settings = {
    add_newline = true;

    scan_timeout = 10;

    username = {
      show_always = true;
      disabled = false;
    };

    hostname = {
      ssh_only = false;
      disabled = false;
    };
  };
}
