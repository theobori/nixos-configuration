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

  cfg = config.${namespace}.system.xdg-utils;
in
{
  options.${namespace}.system.xdg-utils = {
    enable = mkBoolOpt false "Whether or not to manage xdg-utils.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xdg-utils ]; };
}
