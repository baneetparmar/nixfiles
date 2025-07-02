{ inputs, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  nur = inputs.nur.overlays.default;

  nix-vscode-extensions = inputs.nix-vscode-extensions.overlays.default;
}
