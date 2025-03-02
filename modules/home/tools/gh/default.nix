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
  cfg = config.${namespace}.tools.gh;
in
{
  options.${namespace}.tools.gh = with types; {
    enable = mkBoolOpt false "Whether or not to enable github cli tool.";
  };

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [ gh-markdown-preview ];
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
