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

  cfg = config.${namespace}.multimedia.resonance;
in
{
  options.${namespace}.multimedia.resonance = {
    enable = mkBoolOpt false "Whether or not to manage resonance.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ resonance ]; };
}
