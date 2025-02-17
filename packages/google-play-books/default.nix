{
  lib,
  fetchurl,
  symlinkJoin,
  runtimeShell,
  google-chrome,
  writeScriptBin,
  makeDesktopItem,

  # command line arguments which are always set e.g "--disable-gpu"
  commandLineArgs ? [ ],
}:

let
  name = "google-play-books";

  meta = with lib; {
    description = "Open Google Play Books in Google Chrome app mode";
    homepage = google-chrome.meta.homepage or null;
    license = lib.licenses.unfree;
    platforms = google-chrome.meta.platforms or lib.platforms.all;
  };

  desktopItem = makeDesktopItem {
    inherit name;
    exec = name;
    icon = fetchurl {
      name = "google-play-books.png";
      url = "https://www.gstatic.com/images/branding/product/2x/play_books_512dp.png";
      hash = "sha256-ScbMdYVOK4O336E9ktlwseE/GcP/lvMwVX/Xv2twEpU=";
      meta.license = lib.licenses.unfree;
    };
    desktopName = "Google Play Books";
    genericName = "Ebook Reader";
    categories = [ "Network" ];
    startupNotify = true;
  };

  script = writeScriptBin name ''
    #!${runtimeShell}
    exec ${google-chrome}/bin/${google-chrome.meta.mainProgram} ${lib.escapeShellArgs commandLineArgs} \
      --app=https://play.google.com/books \
      --no-first-run \
      --no-default-browser-check \
      --no-crash-upload \
      --disable-extensions \
      --disable-plugins \
      --profile-directory='Profile 1' \
      "$@"
  '';

in

symlinkJoin {
  inherit name meta;
  paths = [
    script
    desktopItem
  ];
}
