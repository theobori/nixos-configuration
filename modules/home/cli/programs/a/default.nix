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

  cfg = config.${namespace}.cli.programs.a;
in
{
  options.${namespace}.cli.programs.a = {
    enable = mkBoolOpt false "Whether or not to enable a.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ a ]; };
}
