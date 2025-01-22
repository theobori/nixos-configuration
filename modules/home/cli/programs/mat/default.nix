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

  cfg = config.${namespace}.cli.programs.mat;
in
{
  options.${namespace}.cli.programs.mat = {
    enable = mkBoolOpt false "Whether or not to enable mat.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ mat2 ]; };
}
