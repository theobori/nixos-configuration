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

  cfg = config.${namespace}.games.teeworlds;
in
{
  options.${namespace}.games.teeworlds = {
    enable = mkBoolOpt false "Enable Teeworlds.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ teeworlds ]; };
}
