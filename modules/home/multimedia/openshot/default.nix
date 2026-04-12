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

  cfg = config.${namespace}.multimedia.openshot;
in
{
  options.${namespace}.multimedia.openshot = {
    enable = mkBoolOpt false "Whether or not to manage openshot.";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.${namespace}.openshot ]; };
}
