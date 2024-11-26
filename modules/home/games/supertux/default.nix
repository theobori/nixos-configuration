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

  cfg = config.${namespace}.games.supertux;
in
{
  options.${namespace}.games.supertux = {
    enable = mkBoolOpt false "Enable supertux.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ superTux ]; };
}
