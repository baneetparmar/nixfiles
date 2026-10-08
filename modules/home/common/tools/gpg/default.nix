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
  cfg = config.${namespace}.tools.gpg;
in
{
  options.${namespace}.tools.gpg = with types; {
    enable = mkBoolOpt false "Whether or not to enable GNU Privacy Guard tool.";
  };
  config = mkIf cfg.enable {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };

    home.activation.importSopsGpgKeys =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ -f /run/secrets/github.com/gpg/public ]; then
          ${pkgs.gnupg}/bin/gpg \
            --import \
            /run/secrets/github.com/gpg/public \
            /run/secrets/github.com/gpg/private
        fi
      '';
  };

}
