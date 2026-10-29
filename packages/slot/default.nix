{
  writeShellApplication,
  python3,
}:
writeShellApplication {
  name = "slot";
  runtimeInputs = [ python3 ];
  text = ''
    python ${./__main__.py}
  '';
}
