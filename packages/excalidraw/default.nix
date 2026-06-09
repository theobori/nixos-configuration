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
  version = "0-unstable-2026-06-07";

  src = fetchFromGitHub {
    owner = "excalidraw";
    repo = "excalidraw";
    rev = "61fe15a51d1a74e5edd564b366889ea8789aec1c";
    hash = "sha256-rkBIFV8nO2sHcnFEQrOS8XwIioRwtfuKJ45DRyOmkr8=";
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
