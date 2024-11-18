{
  lib,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage {
  pname = "pname";
  version = "0.0.1";
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
