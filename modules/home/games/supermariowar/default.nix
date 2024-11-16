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

  cfg = config.${namespace}.games.supermariowar;
in
{
  options.${namespace}.games.supermariowar = {
    enable = mkBoolOpt false "Enable supermariowar.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ supermariowar ]; };
}
