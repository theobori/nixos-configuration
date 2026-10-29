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

  cfg = config.${namespace}.cli.programs.slot;
in
{
  options.${namespace}.cli.programs.slot = {
    enable = mkBoolOpt false "Whether or not to enable slot.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.slot ]; };
}
