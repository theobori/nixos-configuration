{
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "twitchnosub-debug";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "besuper";
    repo = "TwitchNoSub";
    tag = finalAttrs.version;
    hash = "sha256-DVVzX0Jr7W1ISK0V7h5jPG4N8n3zwfFdF45N3/sTcUY=";
  };

  nativeBuildInputs = with pkgs; [ web-ext ];

  buildPhase = ''
    runHook preBuild

    mv firefox-manifest.json manifest.json
    web-ext build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"

    install -v -m644 "web-ext-artifacts/twitchnosub-${finalAttrs.version}.zip" "$dst/twitchnosub@besuper.com.xpi"

    runHook postInstall
  '';
})
