{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.nix-converter;
in
{
  options.${namespace}.cli.programs.nix-converter = {
    enable = mkBoolOpt false "Whether or not to enable nix-converter.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ nix-converter ]; };
}
