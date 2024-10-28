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

  cfg = config.${namespace}.programs.inkscape;
in
{
  options.${namespace}.programs.inkscape = {
    enable = mkBoolOpt false "Whether or not to manage inkscape.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ inkscape ]; };
}
