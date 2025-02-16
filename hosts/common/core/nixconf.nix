{ ... }:
{
  nix = {
    settings = {
      connect-timeout = 5;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      cores = 0;
      warn-dirty = false;
      auto-optimise-store = false;

      trusted-users = [ "@wheel" ];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
        "https://cosmic.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://chaotic-nyx.cachix.org/"
        "https://baneetparmar.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "baneetparmar.cachix.org‐1:DRGYRQ9ZEV6XkMgjZt3owqYKB0JQigGLppGlgLQU6zg="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
