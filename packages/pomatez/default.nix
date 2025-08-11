{ appimageTools, fetchurl }:
let
  pname = "pomatez";
  version = "1.8.0";

  src = fetchurl {
    url = "https://github.com/zidoro/pomatez/releases/download/v${version}/Pomatez-v${version}-linux-x86_64.AppImage";
    hash = "sha256-sBUIMzqoayGjac0/syVZoX8kNpHmis1mzVPlPPj+JnQ=";
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
    description = "Elegant Multi-platform Desktop App for Pomodoro Lovers.";
    homepage = "https://github.com/zidoro/pomatez.git";
    platforms = [ "x86_64-linux" ];
  };
}
