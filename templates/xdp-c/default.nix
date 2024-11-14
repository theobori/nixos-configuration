{
  stdenv,
  lib,
  xdp-tools,
  clang,
  libbpf,
  zlib,
  elfutils,
  pkgsi686Linux,
  llvm_18,
}:
stdenv.mkDerivation {
  pname = "pname";
  version = "version";

  src = ./.;

  buildInputs = [
    xdp-tools
    clang
    libbpf
    zlib
    elfutils
    pkgsi686Linux.glibc
    llvm_18
  ];

  hardeningDisable = [
    "stackprotector"
    "zerocallusedregs"
  ];

  installPhase = ''
    mkdir -p $out/bin

    cp tinyfilter $out/bin
  '';

  meta = {
    description = "My project description";
    homepage = "My project homepage";
    license = lib.licenses.mit;
    mainProgram = "program name";
  };
}
