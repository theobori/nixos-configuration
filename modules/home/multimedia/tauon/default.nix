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

  cfg = config.${namespace}.multimedia.tauon;
in
{
  options.${namespace}.multimedia.tauon = {
    enable = mkBoolOpt false "Whether or not to manage tauon.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ tauon ]; };
}
