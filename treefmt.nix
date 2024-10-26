# treefmt.nix
{ pkgs, ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";
  # Enable the Nix formatter
  programs.nixfmt.enable = true;
}
