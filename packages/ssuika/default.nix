{
  stdenvNoCC,
  fetchFromCodeberg,
  pkg-config,
  raylib,
  clang,
}:
stdenvNoCC.mkDerivation {
  pname = "ssuika";
  version = "0-unstable-2026-06-30";

  src = fetchFromCodeberg {
    owner = "nzuum";
    repo = "ssuika";
    rev = "8c942c0e9ced3ae6a912e8805e909fdc3a5c2670";
    hash = "sha256-8nUyoAeISjAhmAH0M3MKuoCKMy6tMVL5Q/DOa0WnZkQ=";
  };

  nativeBuildInputs = [
    pkg-config
    clang
  ];

  buildInputs = [ raylib ];

  postPatch = ''
    for f in src/sound.c src/grid.c; do
      substituteInPlace $f --replace-fail "assets/" "$out/share/ssuika/assets/"
    done
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out $out/{bin,share/ssuika}
    cp -r bin/ssuika $out/bin
    cp -r assets $out/share/ssuika

    runHook postInstall
  '';

  meta = {
    mainProgram = "ssuika";
  };
}
