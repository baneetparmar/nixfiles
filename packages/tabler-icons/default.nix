{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "tabler-icons";
  version = "3.33.0";

  src = fetchzip {
    url = "https://github.com/tabler/tabler-icons/releases/download/v${version}/tabler-icons-${version}.zip";
    sha256 = "sha256-5TBsu2dRqTj70wqKm4RmnFVIpDGHXrUpGOIvb6KTgQw=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts/tabler-icons" 
    cp webfont/fonts/*.ttf "$out/share/fonts/tabler-icons/"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Tabler Icons font";
    homepage = "https://tabler.io/icons";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
