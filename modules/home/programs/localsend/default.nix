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

  cfg = config.${namespace}.programs.localsend;
in
{
  options.${namespace}.programs.localsend = {
    enable = mkBoolOpt false "Whether or not to manage localsend.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ localsend ]; };
}
