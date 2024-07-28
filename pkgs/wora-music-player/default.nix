{ appimageTools, fetchurl }:
let
  pname = "wora";
  version = "0.3.6";

  src = fetchurl {
    url = "https://github.com/hiaaryan/wora/releases/download/v0.3.6/Wora.v0.3.6.AppImage";
    hash = "sha256-DYFGzLLiTXEp8WX9AHKCb5Tcz17EdKKxjGQ1LMXhp2Q=";
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
    description = "A beautiful player for audiophiles.";
    homepage = "https://github.com/hiaaryan/wora.git";
    platforms = [ "x86_64-linux" ];
  };
}
