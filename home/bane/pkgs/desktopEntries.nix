{ pkgs, ... }:
let
  execApp = pname: "${pkgs.appimage-run}/bin/appimage-run /home/bane/Applications/" + "${pname}";
  setIcon = pname: "/home/bane/Applications/.icons/${pname}";
in
{
  xdg.desktopEntries = {
    warp-terminal = {
      name = "Warp Terminal";
      genericName = "Terminal";
      exec = execApp "Warp.Terminal.AppImage";
      icon = setIcon "Warp.Terminal.png";
      terminal = false;
    };

    fluent-reader = {
      name = "Fluent Reader";
      genericName = "RSS Reader";
      exec = execApp "Fluent.Reader.AppImage";
      icon = setIcon "Fluent.Reader.png";
      terminal = false;
    };

    notion-desktop = {
      name = "Notion";
      genericName = "Notes; Web Application";
      exec = execApp "Notion.AppImage";
      icon = setIcon "Notion.png";
      terminal = false;
    };
  };
}
