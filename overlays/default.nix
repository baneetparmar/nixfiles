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

  hyprpanel = inputs.hyprpanel.overlay;

  nix-vscode-extensions = inputs.nix-vscode-extensions.overlays.default;

  nur = inputs.nur.overlays.default;
}
