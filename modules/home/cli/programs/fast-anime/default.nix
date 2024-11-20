{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.fast-anime;
in
{
  options.${namespace}.cli.programs.fast-anime = {
    enable = mkBoolOpt false "Whether or not to enable fast-anime.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ fast-anime ]; };
}
