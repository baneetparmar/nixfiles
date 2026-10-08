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
  cfg = config.${namespace}.tools.bat;
in
{
  options.${namespace}.tools.bat = with types; {
    enable = mkBoolOpt false "Whether or not to enable bat utility.";
    enableExtras = mkBoolOpt true "Whether or not to enable extra bat utilities.";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages =
        with pkgs.bat-extras;
        mkIf cfg.enableExtras [
          batdiff
          batman
          batgrep
          batwatch
        ];
      config = {
        theme = "tokyonight-storm";
      };
      themes = {
        tokyonight-storm = {
          src = pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "tokyonight.nvim";
            rev = "30d7be361a7fbf187a881f17e574e9213d5108ea";
            hash = "sha256-wD1NKr6KYejErp3oK1u/aJW1L8cIKuEL8v9OUpEdvN8=";
          };
          file = "extras/sublime/tokyonight_night.tmTheme";
        };
      };
    };
  };
}
