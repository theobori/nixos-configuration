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

  cfg = config.${namespace}.games.ninvaders;
in
{
  options.${namespace}.games.ninvaders = {
    enable = mkBoolOpt false "Enable ninvaders.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ ninvaders ]; };
}
