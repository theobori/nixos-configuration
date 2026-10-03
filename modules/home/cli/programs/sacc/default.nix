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

  cfg = config.${namespace}.cli.programs.sacc;
in
{
  options.${namespace}.cli.programs.sacc = {
    enable = mkBoolOpt false "Whether or not to enable sacc.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ sacc ]; };
}
