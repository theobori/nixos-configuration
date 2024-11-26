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

  cfg = config.${namespace}.cli.programs.killall;
in
{
  options.${namespace}.cli.programs.killall = {
    enable = mkBoolOpt false "Whether or not to enable killall.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ killall ]; };
}
