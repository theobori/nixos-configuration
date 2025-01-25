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

  cfg = config.${namespace}.programs.quake-injector;
in
{
  options.${namespace}.programs.quake-injector = {
    enable = mkBoolOpt false "Whether or not to manage Quake Injector.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ quake-injector ]; };
}
