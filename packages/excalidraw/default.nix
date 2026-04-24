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
  version = "0.18.1";

  src = fetchFromGitHub {
    owner = "excalidraw";
    repo = "excalidraw";
    tag = "v${finalAttrs.version}";
    hash = "sha256-XhxNXi6JwBq5vw+/6HQTp6NPX3etmCkdBdNboeBru/k=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = "${finalAttrs.src}/yarn.lock";
    hash = "sha256-otUEr4bGhOGYQmfELShqc8lXbRs0gA0ycbGHzyCW8tc=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    nodejs
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
