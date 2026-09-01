{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      keyFile = "/var/lib/sops-nix/keys.txt";
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
