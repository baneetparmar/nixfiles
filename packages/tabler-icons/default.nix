{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "tabler-icons";
  version = "1.0.0";

  src = ../../assets/fonts/tabler-icons/tabler-icons-outline.ttf;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts/tabler-icons" 
    cp $src "$out/share/fonts/tabler-icons/"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Tabler Icons font";
    homepage = "https://tabler.io/icons";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
