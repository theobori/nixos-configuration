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

  cfg = config.${namespace}.cli.programs.krabby;
in
{
  options.${namespace}.cli.programs.krabby = {
    enable = mkBoolOpt false "Whether or not to enable krabby.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ krabby ]; };
}