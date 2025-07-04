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

  cfg = config.${namespace}.editors.pycharm;
in
{
  options.${namespace}.editors.pycharm = {
    enable = mkBoolOpt false "Whether or not to enable pycharm.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ jetbrains.pycharm-community ]; };
}
