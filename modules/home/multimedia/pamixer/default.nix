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

  cfg = config.${namespace}.multimedia.pamixer;
in
{
  options.${namespace}.multimedia.pamixer = {
    enable = mkBoolOpt false "Whether or not to manage pamixer.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ pamixer ]; };
}
