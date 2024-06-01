{ ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      eh = "home-manager edit";
      hup =
        "cd ~/.nixfiles && nix flake update && home-manager switch --flake ~/.nixfiles/ && cd ~";
      hupb = "cd ~/.nixfiles && nix flake update && home-manager switch --flake ~/nixfiles/ -b backup && cd ~";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";
      cd = "z";
    };
    shellInit =
      "\n      fish_config theme choose 'RosePineMoon'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
    functions = {
      fish_greeting = "krabby random";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
  };
}
