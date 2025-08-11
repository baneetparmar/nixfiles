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
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable Visual Studio Code.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = true;

      profiles.default = {
        enableUpdateCheck = false;
        extensions =
          with pkgs.nix-vscode-extensions.vscode-marketplace;
          with pkgs.nix-vscode-extensions.vscode-marketplace-release;
          [
            enkia.tokyo-night # color theme
            pkief.material-icon-theme # file icon theme
            zguolee.tabler-icons # product icon theme

            # nix
            jnoortheen.nix-ide
            mkhl.direnv
            arrterian.nix-env-selector

            # python
            ms-python.python
            ms-python.debugpy
            charliermarsh.ruff
            njpwerner.autodocstring

            # rust
            rust-lang.rust-analyzer

            # others
            yzhang.markdown-all-in-one # .md
            gruntfuggly.todo-tree
          ];

        userSettings = {
          "window.customTitleBarVisibility" = "auto";
          "editor.fontSize" = 18;
          "editor.fontFamily" =
            "\"Fantasque Sans Mono\", 'Font Awesome 6 Brands', 'Font Awesome 6 Free', 'Font Awesome 6 Free Solid'";
          "terminal.integrated.fontFamily" = "\"Fantasque Sans Mono\", \"FiraCode Nerd Font\"";
          "editor.fontLigatures" = true;
          "terminal.integrated.fontLigatures.enabled" = true;
          "files.autoSave" = "afterDelay";
          "workbench.colorTheme" = "Aura Dark";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.productIconTheme" = "tabler-icons";
          "editor.formatOnSave" = true;
          "editor.cursorStyle" = "block";
          "editor.cursorSmoothCaretAnimation" = "on";
          "terminal.integrated.gpuAcceleration" = "on";
          "window.menuBarVisibility" = "toggle";
          "todo-tree.general.tags" = [
            "BUG"
            "HACK"
            "FIXME"
            "TODO"
            "XXX"
            "[ ]"
            "[x]"
            "DELETE"
          ];
          "todo-tree.highlights.customHighlight" = {
            "DELETE" = {
              "icon" = "x-circle";
              "type" = "tag-and-comment";
              "background" = "#E34234";
              "opacity" = 0.7;
              "foreground" = "white";
              "fontWeight" = "bold";
              "iconColour" = "red";
              "gutterIcon" = true;
              "borderRadius" = "9px";
            };
          };
          "update.mode" = "none";
          "explorer.confirmDelete" = false;
          "codeium.enableConfig" = {
            "*" = true;
            "nix" = true;
          };
          "codeium.enableSearch" = true;
          "window.titleBarStyle" = "native";
        };
      };
    };
  };
}
