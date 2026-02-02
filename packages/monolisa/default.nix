{ stdenv, ... }:
stdenv.mkDerivation {
  pname = "monolisa";
  version = "0.1.0";

  src = ./MonoLisa;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/truetype/

    runHook postInstall
  '';
}
