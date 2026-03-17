{
  lib,
  stdenv,
  fetchFromGitHub,
  SDL2,
  libGL,
  libpng,
  curl,
  libjpeg,
  libmad,
  zlib,
  cmake,
  libvorbis,
}:
stdenv.mkDerivation (_finalAttrs: {
  pname = "joequake";
  version = "0.18.0-unstable-2025-10-15";

  src = fetchFromGitHub {
    owner = "matthewearl";
    repo = "JoeQuake-1";
    rev = "6ead76532a011b6f50d394a6d8a1ed13f259c9e7";
    hash = "sha256-gHkDVy0PPY/++oALDFzBtnhF4459CyDgCeZuzGn1ROw=";
  };

  buildInputs = [
    SDL2
    libGL
    libpng
    curl
    libjpeg
    zlib
    libmad
    libvorbis
  ];

  nativeBuildInputs = [
    cmake
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 trunk/joequake-gl $out/bin/joequake

    runHook postInstall
  '';

  meta = {
    license = with lib.licenses; [ gpl3Plus ];
    maintainers = with lib.maintainers; [ theobori ];
    mainProgram = "joequake";
    platforms = lib.platforms.linux;
  };
})
