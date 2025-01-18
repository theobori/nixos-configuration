{ pkgs, ... }:
let
  inherit (pkgs) stdenvNoCC fetchFromGitHub;
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "twitchnosub";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "besuper";
    repo = "TwitchNoSub";
    rev = "refs/tags/${finalAttrs.version}";
    hash = "sha256-xlWNUiv06ocRwMsnAAI7V7kDlG25psKmZXeODq07MoM=";
  };

  nativeBuildInputs = with pkgs; [ web-ext ];

  buildPhase = ''
    runHook preBuild

    mv firefox-manifest.json manifest.json
    web-ext build

    runHook postBuild
  '';

  patches = [
    # See https://github.com/besuper/TwitchNoSub/issues/156#issuecomment-2592337368
    ./worker.patch
  ];

  installPhase = ''
    runHook preInstall

    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"

    install -v -m644 "web-ext-artifacts/twitchnosub-${finalAttrs.version}.zip" "$dst/twitchnosub@besuper.com.xpi"

    runHook postInstall
  '';
})
