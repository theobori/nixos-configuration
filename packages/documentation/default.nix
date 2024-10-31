{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs) system;

  doc = lib.snowfall.fs.get-file "./docs";
in
pkgs.runCommand "documentation" { } ''
  cp -r ${doc}/* .
  ${inputs.mkdocs-flake.packages.${system}.mkdocs}/bin/mkdocs build --strict
  mv site $out
''
