{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      dup = "just -d ~/.nixfiles --justfile ~/.nixfiles/justfile dup";
      dupb = "just -d ~/.nixfiles --justfile ~/.nixfiles/justfile dupb";
      jtm = "just -d ~/.nixfiles --justfile ~/.nixfiles/justfile ";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";
      cd = "z";
    };
    shellInit = "\n      fish_config theme choose 'RosePineMoon'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
    functions = {
      fish_greeting = "krabby random";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
  };
}
