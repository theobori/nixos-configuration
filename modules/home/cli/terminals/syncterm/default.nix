{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.terminals.syncterm;
in
{
  options.${namespace}.cli.terminals.syncterm = {
    enable = mkBoolOpt false "Whether or not to enable SyncTERM.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ syncterm ]; };
}
