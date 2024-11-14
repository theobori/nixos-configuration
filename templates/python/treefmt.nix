{ ... }:
{
  projectRootFile = "flake.nix";
  programs.black.enable = true;
  programs.nixfmt.enable = true;
}
