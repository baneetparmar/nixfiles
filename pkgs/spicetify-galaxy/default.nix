{ stdenvNoCC, fetchgit, ... }:

stdenvNoCC.mkDerivation {
  pname = "spicetify-galaxy";
  version = "1.0.0";

  src = fetchgit {
    url = "https://github.com/harbassan/spicetify-galaxy.git";
    rev = "2b2e33c02c5adffd6737e4a93c261e961fad8eca";
    hash = "sha256-cerdcfmPuKMnFCJg+wmOZ7bwesheWWWVckVxWrCn+48=";
    leaveDotGit = false;
    deepClone = false;
    fetchSubmodules = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r $src/ $out/
  '';

  meta = {
    description = "Spicetify Galaxy Theme";
    homepage = "https://github.com/harbassan/spicetify-galaxy";
  };
}
