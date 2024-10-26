{ pkgs, lib, ... }:
let
  version = "4.0.0";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "sddm-dracula";
  version = version;

  src = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "v${version}";
    sha256 = "sha256-q3/uBd+jPFhiVAllyhqf486Jxa0mnCDSIqcm/jwGtJA=";
  };

  propagatedInputs = with pkgs; [ cantarell-fonts ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes

    mv kde/sddm/Dracula $out/share/sddm/themes/sddm-dracula

    cp ${pkgs.theobori-org.wallpapers.nix-simple} $out/share/sddm/themes/sddm-dracula/assets/background.jpg
  '';
}
