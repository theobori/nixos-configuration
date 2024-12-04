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

  cfg = config.${namespace}.cli.programs.genact;
in
{
  options.${namespace}.cli.programs.genact = {
    enable = mkBoolOpt false "Whether or not to enable genact.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ genact ]; };
}
