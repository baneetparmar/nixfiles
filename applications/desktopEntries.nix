{ pkgs, ... }:
let execAppImage = pname: "${pkgs.appimage-run}/bin/appimage-run /home/bane/Applications/" + "${pname}";
in
{
  xdg.desktopEntries = {
    warp-terminal = {
      name = "Warp Terminal";
      genericName = "Terminal";
      exec = execAppImage "Warp.Terminal.AppImage";
      terminal = false;
    };

    fluent-reader = {
      name = "Fluent Reader";
      genericName = "RSS Reader";
      exec = execAppImage "Fluent.Reader.AppImage";
      terminal = false;
    };
  };
}
