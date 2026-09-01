{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
  ];

  sops = {
    defaultSopsFile = ../../../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      keyFile = "/etc/sops/age/keys.txt";
    };
    secrets = {
      github_access_token = { };
    };

    templates.github_access_token_prelude = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder.github_access_token}
      '';
      mode = "0444"; # must be readable by all users
    };
  };
}
