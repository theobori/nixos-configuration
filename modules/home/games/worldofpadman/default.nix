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

  cfg = config.${namespace}.games.worldofpadman;
in
{
  options.${namespace}.games.worldofpadman = {
    enable = mkBoolOpt false "Enable worldofpadman.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.worldofpadman ]; };
}
