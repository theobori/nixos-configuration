{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.onefetch;
in
{
  options.${namespace}.cli.programs.onefetch = {
    enable = mkBoolOpt false "Whether or not to enable onefetch.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ onefetch ]; };
}
