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

  cfg = config.${namespace}.cli.programs.screen;
in
{
  options.${namespace}.cli.programs.screen = {
    enable = mkBoolOpt false "Whether or not to enable screen.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ screen ]; };
}
