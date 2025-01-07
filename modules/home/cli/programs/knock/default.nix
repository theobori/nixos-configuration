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

  cfg = config.${namespace}.cli.programs.knock;
in
{
  options.${namespace}.cli.programs.knock = {
    enable = mkBoolOpt false "Whether or not to enable knock.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.knock ]; };
}
