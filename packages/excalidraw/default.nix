{
  lib,
  stdenvNoCC,
  fetchYarnDeps,
  fetchFromGitHub,
  yarnConfigHook,
  yarnBuildHook,
  nodejs,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "excalidraw-app";
  version = "0-unstable-2026-06-22";

  src = fetchFromGitHub {
    owner = "excalidraw";
    repo = "excalidraw";
    rev = "0642e72cfa2d9a71198200e52f37399384610ee3";
    hash = "sha256-9dzeGALt6jm4PqBWv+J/nlQQi00xhrRSWLlbqa1sfhg=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = "${finalAttrs.src}/yarn.lock";
    hash = "sha256-c8xy+/fXrPVCsdUXo3doDq8afrXVr3cCUA3C2ANijqE=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    nodejs
    yarnConfigHook
    yarnBuildHook
  ];

  yarnBuildScript = "build:app:docker";

  installPhase = ''
    runHook preInstall

    cp -r excalidraw-app/build $out

    runHook postInstall
  '';

  __structuredAttrs = true;

  meta = {
    changelog = "https://github.com/excalidraw/excalidraw/blob/${finalAttrs.src.tag}/packages/excalidraw/CHANGELOG.md";
    description = "Virtual whiteboard for sketching hand-drawn like diagrams";
    homepage = "https://github.com/excalidraw/excalidraw";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theobori ];
  };
})
