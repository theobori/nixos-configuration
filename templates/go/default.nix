{ lib, buildGoModule }:
buildGoModule {
  pname = "go-template";
  version = "0.0.1";

  src = ./.;

  vendorHash = lib.fakeHash;

  meta = {
    description = "My project description";
    homepage = "My project homepage";
    license = lib.licenses.mit;
    mainProgram = "program name";
  };
}
