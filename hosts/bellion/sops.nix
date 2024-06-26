{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = /home/bane/.config/sops/age/keys.txt;

    secrets = {
      passwd = { };
    };
  };
}
