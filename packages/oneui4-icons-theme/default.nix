{
  lib,
  stdenvNoCC,
  fetchzip,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "oneui4-icons";
  version = "1.0.0";

  src = fetchzip {
    url = "https://tinyurl.com/oneui4-icons";
    hash = "sha256-6zmzIqxNF1MvdQhqdJLeFB/lw1/BMdk/vcBq6NITovw=";
    recursiveHash = true;
    extension = "tar.gz";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r $src/* $out/share/icons/
  '';

  dontBuild = true;

  meta = with lib; {
    description = "One UI 4 Icons Pack";
    homepage = "https://github.com/mjkim0727/OneUI4-Icons";
    platforms = platforms.linux;
  };
}
