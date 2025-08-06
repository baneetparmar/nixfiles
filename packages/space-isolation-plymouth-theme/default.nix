{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  resolution ? "1920x1080",
  ...
}:

let
  version = "0.1.0-beta";
in
stdenvNoCC.mkDerivation {
  pname = "space-isolation-plymouth-theme";
  inherit version;

  src = fetchFromGitHub {
    owner = "callmenoodles";
    repo = "space-isolation-plymouth";
    rev = "31a40fbc1f78e7719d8564da44be0160e672aca0";
    hash = "sha256-l46IPYxM7gvO0kZLgu5QQkOAwM4hfBpDKjNdHLreSSE=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth/themes/space-isolation
    cp -r ${resolution}/* $out/share/plymouth/themes/space-isolation/
    substituteInPlace $out/share/plymouth/themes/space-isolation/space-isolation.plymouth \
      --replace-fail "/usr/" "$out/"

    runHook postInstall
  '';

  meta = with lib; {
    description = "space isolation plymouth theme";
    homepage = "https://github.com/callmenoodles/space-isolation-plymouth";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
