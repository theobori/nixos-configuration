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

  cfg = config.${namespace}.browsers.lagrange;
in
{
  options.${namespace}.browsers.lagrange = {
    enable = mkBoolOpt false "Whether or not to manage lagrange.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ lagrange ]; };
}
