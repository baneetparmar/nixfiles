{ pkgs, ... }:
{
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs; [ luarocks ];
  };
}
