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

  cfg = config.${namespace}.cli.programs.tldr;
in
{
  options.${namespace}.cli.programs.tldr = {
    enable = mkBoolOpt false "Whether or not to enable tldr.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ tldr ]; };
}
