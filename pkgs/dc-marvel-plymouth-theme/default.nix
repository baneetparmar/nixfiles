{
  stdenv,
  fetchurl,
  lib,
  unzip,
}:
let
  version = "1.0";
  pname = "dc-marvel-plymouth-theme";
  srcs = fetchurl {
    url = "https://github.com/MrVivekRajan/Plymouth-Themes/releases/download/dc/DcMarvel.tar.gz";
    sha256 = "0mx5ks8dqak64xim13wz5f5ayz40nq1ah2p38as0c1wjkww1zzg6";
  };
in
stdenv.mkDerivation {
  inherit pname version srcs;

  nativeBuildInputs = [
    unzip
  ];

  sourceRoot = ".";
  unpackCmd = "tar xzf $curSrc";
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes
    mv DcMarvel $out/share/plymouth/themes/
    find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
  '';

  meta = with lib; {
    description = "plymouth themes from MrVivekRajan";
    homepage = "https://github.com/MrVivekRajan/Plymouth-Themes";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
