{
  lib,
  stdenv,
  fetchurl,
  pkgs,
  ...
}:

stdenv.mkDerivation rec {
  pname = "fdm";
  version = "6.29.1";

  src = fetchurl {
    url = "https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb";
    hash = "sha256-IS+WFtoU65XL/Ufs+f+gttq6BBPgDSLFKUtlWfNtxJM=";
  };

  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src .

    runHook postUnpack
  '';

  nativeBuildInputs = with pkgs; [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
    qt6.wrapQtAppsHook
  ];

  dontWrapQtApps = true;

  buildInputs =
    with pkgs;
    [
      makeWrapper
      openssl
      ffmpeg
      xdg-utils
      libtorrent-rasterbar
      qt6.qtbase
    ]
    ++ (with gst_all_1; [
      gstreamer
      gst-libav
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
    ]);

  autoPatchelfIgnoreMissingDeps = [
    "libmysqlclient.so.21"
    "libmimerapi.so"
  ];

  runtimeDependencies = with pkgs; [
    (lib.getLib udev)
    openssl
    ffmpeg
    xdg-utils
    libtorrent-rasterbar
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r opt/freedownloadmanager $out
    cp -r usr/share $out
    ln -s $out/freedownloadmanager/fdm $out/bin/${pname}

    substituteInPlace $out/share/applications/freedownloadmanager.desktop \
      --replace 'Exec=/opt/freedownloadmanager/fdm' 'Exec=${pname}' \
      --replace "Icon=/opt/freedownloadmanager/icon.png" "Icon=$out/freedownloadmanager/icon.png"

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram "$out/bin/fdm" --set QT_QPA_PLATFORM xcb
  '';

  meta = with lib; {
    description = "A smart and fast internet download manager";
    homepage = "https://www.freedownloadmanager.org";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
