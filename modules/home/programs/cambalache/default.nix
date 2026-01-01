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

  cfg = config.${namespace}.programs.qdirstat;
in
{
  options.${namespace}.programs.qdirstat = {
    enable = mkBoolOpt false "Whether or not to manage qdirstat.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ qdirstat ]; };
}
