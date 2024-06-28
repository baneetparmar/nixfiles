{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      up = "nh os switch -n";
      dup = "nix flake update $FLAKE && nh os switch -n";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";
      cd = "z";
    };
    shellInit = "\n      fish_config theme choose 'tokyoNightStorm'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
    functions = {
      fish_greeting = "krabby random --no-title";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
  };
}
