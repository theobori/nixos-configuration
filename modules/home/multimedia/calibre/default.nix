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

  cfg = config.${namespace}.multimedia.calibre;
in
{
  options.${namespace}.multimedia.calibre = {
    enable = mkBoolOpt false "Whether or not to manage calibre.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ calibre ]; };
}
