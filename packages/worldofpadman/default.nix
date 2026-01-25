{
  lib,
  fetchzip,
  stdenvNoCC,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  SDL,
  libogg,
  libvorbis,
  mesa,
  autoPatchelfHook,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "worldofpadman";
  version = "1.7.0";

  src = fetchzip {
    url = "https://github.com/PadWorld-Entertainment/worldofpadman/releases/download/v${finalAttrs.version}/wop-${finalAttrs.version}-unified.zip";
    hash = "sha256-oNN+6RBydkmxBCYBSJgPJMcrXZNfrVBt0UqRRJOTgAM=";
    stripRoot = false;
  };

  buildInputs = [
    SDL
    libogg
    libvorbis
    mesa
  ];

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
  ];

  desktopItems = [
    (makeDesktopItem {
      exec = finalAttrs.meta.mainProgram;
      name = "worldofpadman";
      icon = "wop";
      comment = "Cartoon-style multiplayer first-person shooter";
      categories = [
        "Game"
        "ActionGame"
      ];
      desktopName = "World Of Padman";
    })
  ];

  installPhase = ''
        runHook preInstall

        gamedir=$out/share/worldofpadman

        mkdir -p $out/bin $gamedir $out/share/icons/hicolor/scalable/apps

        # See https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=worldofpadman
        #
        # Install binaries
        install -D -m755 wop.x86_64 "$gamedir/wop.bin"
        install -D -m755 wopded.x86_64 "$gamedir/wopded.bin"
    	  install -D -m755 renderer_opengl2_x86_64.so "$gamedir/renderer_opengl2_x86_64.so"
    	  install -D -m755 renderer_opengl1_x86_64.so "$gamedir/renderer_opengl1_x86_64.so"

        cat >wop.sh <<EOF
    #!/bin/bash
    cd $gamedir && exec ./wop.bin "\$@"
    EOF
      cat >wopded.sh <<EOF
    #!/bin/bash
    cd $gamedir && exec ./wopded.bin "\$@"
    EOF

        install -D -m755 wop.sh "$out/bin/wop"
    	  install -D -m755 wopded.sh "$out/bin/wopded"

        cp --recursive wop "$gamedir/wop"
    	  cp --recursive XTRAS "$gamedir/XTRAS"
    	  install -D -m755 XTRAS/wop.svg "$out/share/icons/hicolor/scalable/apps/wop.svg"

        runHook postInstall
  '';

  meta = {
    description = "incredibly carefully designed and colorful freeware fun shooter";
    homepage = "https://worldofpadman.net/en/";
    license = with lib.licenses; [ gpl3Plus ];
    maintainers = with lib.maintainers; [ theobori ];
    mainProgram = "wop";
    platforms = [ "x86_64-linux" ];
  };
})
