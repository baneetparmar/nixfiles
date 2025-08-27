{
  lib,
  config,
  namespace,
  options,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.fish;
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
      shellAbbrs = {
        ds = "devshell";
      };

      shellInit = ''
        direnv hook fish | source
        zoxide init fish | source
      '';
      functions = {
        fish_greeting = "${pkgs.krabby}/bin/krabby random --no-title";
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
        devshell = ''
          set action $argv[1]
          set template $argv[2]
          set url "https://flakehub.com/f/the-nix-way/dev-templates/*#$template"

          switch $action
              case -c create
                  nix --experimental-features 'nix-command flakes' flake init --template $url
                  if command -v direnv >/dev/null
                      echo use flake > .envrc; direnv allow
                  end
                  echo "Environment:'$template' ready."
              case -d destroy
                  rm -rf flake.nix flake.lock .envrc .direnv .venv node_modules target dist build
                  echo "Environment nuked."
              case -l list
                  echo "Available templates:"
                  echo "bun c-cpp clojure cue dhall elixir elm"
                  echo "empty gleam go hashi haskell haxe java"
                  echo "jupyter kotlin latex lean4 nickel nim"
                  echo "nix node ocaml odin opa php platformio"
                  echo "protobuf pulumi purescript python r ruby"
                  echo "rust scala shell swi-prolog swift typst vlang zig"
              case '*'
                  echo "Usage: devshell [create|destroy|list] <template>"
                  echo "-c / create    - setup environment"
                  echo "-d / destroy   - remove environment files"
                  echo "-l / list      - show templates"
                  echo "Short: ds -c python"
              end
        '';
      };
    };
  };
}
