{
  vkquake,
  makeDesktopItem,
  copyDesktopItems,
  ...
}:
vkquake.overrideAttrs (
  _final: prev: {
    nativeBuildInputs = prev.nativeBuildInputs ++ [ copyDesktopItems ];

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/bin"
      cp vkquake "$out/bin"

      mkdir -p $out/share/icons/hicolor/256x256/apps
      cp ../Misc/vkQuake_256.png $out/share/icons/hicolor/256x256/apps/vkquake.png

      runHook postInstall
    '';

    desktopItems = [
      (makeDesktopItem {
        exec = prev.meta.mainProgram;
        name = "vkquake";
        icon = "vkquake";
        comment = prev.meta.description;
        desktopName = "vkQuake";
        categories = [ "Game" ];
      })
    ];
  }
)
