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

  cfg = config.${namespace}.programs.pablodraw;
in
{
  options.${namespace}.programs.pablodraw = {
    enable = mkBoolOpt false "Whether or not to manage pablodraw.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ pablodraw ]; };
}
