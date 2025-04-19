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

  cfg = config.${namespace}.games.apotris;
in
{
  options.${namespace}.games.apotris = {
    enable = mkBoolOpt false "Enable apotris.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.apotris ]; };
}
