{ stdenv, texlive }:
stdenv.mkDerivation {
  pname = "pname";
  version = "0.0.1";

  src = ./.;

  buildInputs = [
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        fourier
        lastpage
        etaremune
        datetime2
        ;
    })
  ];

  buildPhase = ''
    runHook preBuild

    pdflatex my_pdf.tex

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    mv my_pdf.pdf $out

    runHook postInstall
  '';
}
