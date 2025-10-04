{
  lib,
  buildPythonPackage,
  setuptools,
  pytestCheckHook,
}:
buildPythonPackage {
  pname = "pname";
  version = "0.0.1";
  pyproject = true;

  src = ./.;

  build-system = [ setuptools ];

  pythonImportsCheck = [ "project" ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "My project description";
    homepage = "My project homepage";
    license = lib.licenses.mit;
  };
}
