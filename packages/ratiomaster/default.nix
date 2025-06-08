{
  lib,
  fetchzip,
  mono,
  stdenvNoCC,
  makeWrapper,
  gtk2,
  makeDesktopItem,
  copyDesktopItems,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ratiomaster";
  version = "0.43";

  src = fetchzip {
    url = "https://github.com/NikolayIT/RatioMaster.NET/releases/download/${finalAttrs.version}/RatioMaster.NET_${finalAttrs.version}.zip";
    hash = "sha256-F45kWitfysAGQg0MgLaLXiKsK8wHbAS+5Ltjtk8YuAQ=";
    stripRoot = false;
  };

  buildInputs = [ gtk2 ];

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
      exec = finalAttrs.meta.mainProgram;
      name = "RatioMaster";
      icon = "ratiomaster";
      comment = "Torrent tracker upload and download faker";
      desktopName = "RatioMaster";
      categories = [
        "Utility"
        "Network"
      ];
      keywords = [ "Internet" ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,share/RatioMaster.NET_${finalAttrs.version}}

    dst="$out/share/RatioMaster.NET_${finalAttrs.version}/RatioMaster.NET.exe"

    install RatioMaster.NET.exe $dst
    # This mono version derivation does not contain the meta.mainProgram field
    makeWrapper "${mono}/bin/mono" $out/bin/RatioMaster \
      --add-flags "$dst" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ gtk2 ]}

    # Install the RatioMaster icon
    install -D ${./ratiomaster.png} "$out/share/icons/hicolor/256x256/apps/ratiomaster.png"

    runHook postInstall
  '';

  meta = {
    description = "Ratiomaster.NET is a small standalone application which fakes upload and download stats of a torrent to almost all bittorrent trackers";
    homepage = "https://ratiomaster.net/";
    changelog = "https://github.com/NikolayIT/RatioMaster.NET/releases";
    license = with lib.licenses; [ mit ];
    maintainers = with lib.maintainers; [ theobori ];
    mainProgram = "RatioMaster";
  };
})
