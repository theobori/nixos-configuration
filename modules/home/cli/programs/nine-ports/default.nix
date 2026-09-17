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

  cfg = config.${namespace}.cli.programs.nine-ports;
in
{
  options.${namespace}.cli.programs.nine-ports = {
    enable = mkBoolOpt false "Whether or not to enable nine-ports.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ nine-ports ]; };
}
