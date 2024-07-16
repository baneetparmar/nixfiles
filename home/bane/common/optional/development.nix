{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    vscode

    gcc
    glibc
    gnumake
    lldb_16

    bacon
    rustup

    pipx
    poetry
    python312
    python312Packages.pip

    bun
    yarn
    nodejs_22
    nodePackages.ijavascript
  ];
}
