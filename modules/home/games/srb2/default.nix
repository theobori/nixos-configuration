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

  cfg = config.${namespace}.games.srb2;
in
{
  options.${namespace}.games.srb2 = {
    enable = mkBoolOpt false "Enable Sonic Robo Blast 2.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ srb2 ]; };
}
