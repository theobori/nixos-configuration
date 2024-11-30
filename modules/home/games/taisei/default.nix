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

  cfg = config.${namespace}.games.taisei;
in
{
  options.${namespace}.games.taisei = {
    enable = mkBoolOpt false "Enable taisei.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ taisei ]; };
}
