{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.nixpkgs-vet;
in
{
  options.${namespace}.cli.programs.nixpkgs-vet = {
    enable = mkBoolOpt false "Whether or not to enable nixpkgs-vet.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ nixpkgs-vet ]; };
}
