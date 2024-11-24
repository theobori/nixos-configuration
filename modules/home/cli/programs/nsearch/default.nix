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

  cfg = config.${namespace}.cli.programs.nsearch;
in
{
  options.${namespace}.cli.programs.nsearch = {
    enable = mkBoolOpt false "Whether or not to enable nsearch.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ nsearch ]; };
}
