{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.manix;
in
{
  options.${namespace}.cli.programs.manix = {
    enable = mkBoolOpt false "Whether or not to enable manix.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ manix ]; };
}
