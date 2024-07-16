{
  appimageTools,
  lib,
  fetchurl,
}:
let
  pname = "Notion";
  version = "2.3.2";

  src = fetchurl {
    url = "https://tinyurl.com/notion-desktop";
    sha256 = "06ki585zpdzsljknal6by6dac24r6r82w844h70ngzqf6y7lwxgy";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Notion Desktop";
    platforms = [ "x86_64-linux" ];
  };
}
