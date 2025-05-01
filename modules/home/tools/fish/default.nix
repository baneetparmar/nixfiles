{
  lib,
  namespace,
  config,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.fish;
  theme = "tokyoNightStorm";
in
{
  options.${namespace}.tools.fish = with types; {
    enable = mkBoolOpt true "Whether or not to enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        up = "nh os boot";
        dup = "nh os boot -u";
        ls = "lsd";
      };

      shellInit = ''
          direnv hook fish | source
          zoxide init fish | source

          # TokyoNight Color Palette
        set -l foreground c0caf5
        set -l selection 283457
        set -l comment 565f89
        set -l red f7768e
        set -l orange ff9e64
        set -l yellow e0af68
        set -l green 9ece6a
        set -l purple 9d7cd8
        set -l cyan 7dcfff
        set -l pink bb9af7

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_option $pink
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set -g fish_pager_color_selected_background --background=$selection
      '';
      functions = {
        fish_greeting = "${pkgs.krabby}/bin/krabby random --no-title";
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };
    };
  };
}
