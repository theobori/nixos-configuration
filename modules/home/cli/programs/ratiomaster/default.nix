{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.ratiomaster;
in
{
  options.${namespace}.cli.programs.ratiomaster = {
    enable = mkBoolOpt false "Whether or not to enable ratiomaster.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.ratiomaster ]; };
}
