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

  cfg = config.${namespace}.browsers.gophie;
in
{
  options.${namespace}.browsers.gophie = {
    enable = mkBoolOpt false "Whether or not to manage gophie.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.gophie ]; };
}
