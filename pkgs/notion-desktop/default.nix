{ appimageTools, fetchurl }:
let
  pname = "notion";
  version = "3.10.0-1";

  src = fetchurl {
    url = "https://github.com/kidonng/notion-appimage/releases/download/3.10.0-1/Notion-3.10.0-1.AppImage";
    hash = "sha256-oWmDc8E3Mz5L0QXJsjdePW0U7ENHYt37uLjENJCnNEA=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Notion Desktop";
    platforms = [ "x86_64-linux" ];
  };
}
