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

  meta = {
    description = "Cyber-re Grub Theme";
    homepage = "https://www.gnome-look.org/p/1420727";
    platforms = [
      "x86_64-linux"
      "i686-linux"
    ];
  };
}
