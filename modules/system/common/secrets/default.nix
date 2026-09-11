{
  inputs,
  config,
  lib,
  namespace,
  system,
  ...
}:
with lib.${namespace};
let
  isDarwin = lib.hasSuffix "-darwin" system;
  home = homeDir system config.${namespace}.user.name;
  owner = config.${namespace}.user.name;
in
{
  imports = [
    (if isDarwin then inputs.sops-nix.darwinModules.sops else inputs.sops-nix.nixosModules.sops)
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    validateSopsFiles = false;

    age.keyFile = if isDarwin then "/etc/sops/age/keys.txt" else "/var/lib/sops-nix/keys.txt";

    secrets = {
      # github.com
      "github.com/username" = { };
      "github.com/access_token" = { };
      "github.com/ssh/public" = {
        inherit owner;
        path = "${home}/.ssh/github_personal.pub";
        mode = "0444";
      };
      "github.com/ssh/private" = {
        inherit owner;
        path = "${home}/.ssh/github_personal";
        mode = "0400";
      };
      "github.com/gpg/public" = {
        inherit owner;
        path = "${home}/.gnupg/github.pub.asc";
        mode = "0444";
      };
      "github.com/gpg/private" = {
        inherit owner;
        path = "${home}/.gnupg/github.asc";
        mode = "0400";
      };

      # google.google.com
      "google.google.com/username" = { };
      "google.google.com/ssh/public" = {
        inherit owner;
        path = "${home}/.ssh/google.pub";
        mode = "0444";
      };
      "google.google.com/ssh/private" = {
        inherit owner;
        path = "${home}/.ssh/google";
        mode = "0400";
      };

      # pesto.dev
      "pesto.dev/username" = { };
      "pesto.dev/ssh/public" = {
        inherit owner;
        path = "${home}/.ssh/pesto.pub";
        mode = "0444";
      };
      "pesto.dev/ssh/private" = {
        inherit owner;
        path = "${home}/.ssh/pesto";
        mode = "0400";
      };
    };

    templates.github_access_token_prelude = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder."github.com/access_token"}
      '';
      mode = "0444";
    };
  };
}
