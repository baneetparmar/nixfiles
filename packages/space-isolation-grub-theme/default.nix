{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  resolution ? "1920x1080",
  ...
}:

let
  version = "0.2.0";
in

stdenvNoCC.mkDerivation {
  pname = "space-isolation-grub-theme";
  version = "v${version}";

  src = fetchFromGitHub {
    owner = "callmenoodles";
    repo = "space-isolation";
    rev = "fc1968098772ae77adc6cf4bcee9d008f2f8f6ed";
    hash = "sha256-FjwBmcre07eKYR9N0+q4mgigv6qnOSloFJ9Ozzfiwak=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ${resolution}/* $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "space isolation grub theme";
    homepage = "https://github.com/callmenoodles/space-isolation";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
