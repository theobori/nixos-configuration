{
  lib,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage {
  pname = "pname";
  version = "version";
  pyproject = true;

  src = ./.;

  dependencies = [ ];

  nativeBuildInputs = [ setuptools ];

  pythonImportsCheck = [ "complete" ];

  meta = {
    description = "My project description";
    homepage = "My project homepage";
    license = lib.licenses.mit;
    mainProgram = "program name";
  };
}
