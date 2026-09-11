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
      builtins.concatMap (os: builtins.map (mkEntry arch os) (childrenOf (hostsDir + "/${arch}/${os}"))) (
        childrenOf (hostsDir + "/${arch}")
      )
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
    builders: os: builders.${os} or (throw "lib.custom.selectBuilder: no builder for os '${os}'");

  ## Pick a value based on the platform pkgs was built for. Named attrs
  ## instead of positional args, so there's no linux/darwin order to mix up
  ## at the call site.
  ##
  ## ```nix
  ## shell = forPlatform pkgs { linux = pkgs.fish; darwin = pkgs.zsh; };
  ## ```
  ##
  #@ Pkgs -> { linux :: Any, darwin :: Any } -> Any
  forPlatform = pkgs: { linux, darwin }: if pkgs.stdenv.isLinux then linux else darwin;

  ## Splice a package into a list only when building on Linux - `[ ]` on
  ## darwin, so it disappears from `home.packages`/`environment.systemPackages`
  ## cleanly instead of failing to build.
  ##
  ## ```nix
  ## home.packages = with pkgs; [ ripgrep ] ++ ifLinux pkgs "glibc";
  ## ```
  ##
  #@ Pkgs -> String -> [ Package ]
  ifLinux = pkgs: name: lib.optional pkgs.stdenv.isLinux pkgs.${name};

  ## Same as ifLinux, for darwin/macOS-only packages.
  ##
  ## ```nix
  ## home.packages = with pkgs; [ ripgrep ] ++ ifDarwin pkgs "cocoapods";
  ## ```
  ##
  #@ Pkgs -> String -> [ Package ]
  ifDarwin = pkgs: name: lib.optional pkgs.stdenv.isDarwin pkgs.${name};

  ## The OS's home-directory root - "/home" on Linux, "/Users" on darwin.
  ##
  ## ```nix
  ## "${homeRoot system}/${username}/.config"
  ## ```
  ##
  #@ String -> String
  homeRoot = system: if lib.hasSuffix "-darwin" system then "/Users" else "/home";

  ## Full home directory for `username` on `system`, OS-correct root included.
  ##
  ## ```nix
  ## identityFile = [ "${homeDir system username}/.ssh/github_personal" ];
  ## ```
  ##
  #@ String -> String -> String
  homeDir = system: username: "${homeRoot system}/${username}";

  ## The root user's home directory - "/root" on Linux, "/var/root" on
  ## darwin.
  ##
  ## ```nix
  ## "${rootDir system}/.config/some-system-tool"
  ## ```
  ##
  #@ String -> String
  rootDir = system: if lib.hasSuffix "-darwin" system then "/var/root" else "/root";

  ## Recursively collect every `default.nix` under `dir`.
  ##
  ## Credit: @infinisil
  ## https://github.com/Infinisil/system/blob/df9232c4b6cec57874e531c350157c37863b91a0/config/new-modules/default.nix
  ##
  ## ```nix
  ## lib.custom.collectDefaultNix ./modules/home/common
  ## ```
  ##
  #@ Path -> [ Path ]
  collectDefaultNix =
    dir:
    let
      getDir =
        d:
        mapAttrs (file: type: if type == "directory" then getDir "${d}/${file}" else type) (
          builtins.readDir d
        );
      files = d: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir d));
    in
    builtins.map (file: dir + "/${file}") (
      builtins.filter (file: builtins.baseNameOf file == "default.nix") (files dir)
    );

  ## Auto-import a common/{linux,darwin} module tree: always pulls in
  ## `<dir>/common`, plus `<dir>/linux` or `<dir>/darwin` depending on the
  ## platform `pkgs` was built for. A subfolder that doesn't exist yet
  ## (e.g. no darwin/ modules so far) is skipped rather than erroring.
  ##
  ## ```nix
  ## imports = lib.custom.autoImport { inherit pkgs; dir = ./.; };
  ## ```
  ##
  #@ { pkgs :: Pkgs, dir :: Path } -> [ Path ]
  autoImport =
    { system, dir }:
    let
      osDir = if lib.hasSuffix "-darwin" system then "darwin" else "linux";
      subdirs = builtins.filter (d: builtins.pathExists (dir + "/${d}")) [
        "common"
        osDir
      ];
    in
    builtins.concatMap (d: collectDefaultNix (dir + "/${d}")) subdirs;
}
