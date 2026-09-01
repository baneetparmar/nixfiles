{ lib, ... }:

with lib;
rec {
  ## Create a NixOS module option.
  ##
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  ## Create a boolean NixOS module option.
  ##
  ## ```nix
  ## lib.mkBoolOpt true "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt = mkOpt types.bool;

  ## Create a boolean NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkBoolOpt true
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt' = mkOpt' types.bool;

  enabled = {
    ## Quickly enable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ true
    enable = true;
  };

  disabled = {
    ## Quickly disable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ false
    enable = false;
  };

  ## Recursively discover hosts laid out as <hostsDir>/<arch>/<os>/<hostname>.
  ##
  ## ```nix
  ## lib.custom.discoverHosts ./hosts
  ## # -> [ { arch = "x86_64"; os = "linux"; hostname = "bellion";
  ## #        system = "x86_64-linux"; path = ./hosts/x86_64/linux/bellion; } ... ]
  ## ```
  ##
  #@ Path -> [ AttrSet ]
  discoverHosts =
    hostsDir:
    let
      childrenOf = dir: builtins.attrNames (builtins.readDir dir);
      mkEntry = arch: os: hostname: {
        inherit arch os hostname;
        system = "${arch}-${os}";
        path = hostsDir + "/${arch}/${os}/${hostname}";
      };
    in
    builtins.concatMap (
      arch:
      builtins.concatMap (
        os: builtins.map (mkEntry arch os) (childrenOf (hostsDir + "/${arch}/${os}"))
      ) (childrenOf (hostsDir + "/${arch}"))
    ) (childrenOf hostsDir);

  ## Pick the right system-builder (nixosSystem/darwinSystem/...) for a
  ## discovered host's `os`, out of a { linux = ...; darwin = ...; } table.
  ##
  ## ```nix
  ## lib.custom.selectBuilder { linux = nixosSystem; darwin = darwinSystem; } "linux"
  ## ```
  ##
  #@ AttrSet -> String -> Any
  selectBuilder =
    builders: os:
    builders.${os} or (throw "lib.custom.selectBuilder: no builder for os '${os}'");
}
