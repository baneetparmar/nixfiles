{...}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      eh = "home-manager edit";
      hup =
        "cd ~/.nixfiles && nix flake update && home-manager switch --flake ~/.nixfiles/ && cd ~";
      lv = "lvim";
      ls = "lsd";
      cat = "bat";
      du = "dust";
    };
    shellInit =
      "\n      fish_config theme choose 'RosePineMoon'\n      direnv hook fish | source\n      zoxide init fish | source\n    ";
  };
}
