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

  cfg = config.${namespace}.games.xonotic;
in
{
  options.${namespace}.games.xonotic = {
    enable = mkBoolOpt false "Enable xonotic.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xonotic ]; };
}
