{ stdenvNoCC, fetchzip, ... }:

stdenvNoCC.mkDerivation {
  pname = "cyberre-grub-theme";
  version = "1.0.0";

  src = fetchzip {
    url = "https://tinyurl.com/cyberre-grub-theme";
    hash = "sha256-RWEQHqWjSZtDlFjJlsQBig/bBaZL/srfez1qTzE+Qrw=";
    recursiveHash = true;
    extension = "tar.gz";
  };

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r $src/CyberRe/* $out/
  '';
}
