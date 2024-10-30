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

  cfg = config.${namespace}.games.taterclient-ddnet;
in
{
  options.${namespace}.games.taterclient-ddnet = {
    enable = mkBoolOpt false "Enable the TaterClient (DDNet).";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ taterclient-ddnet ]; };
}
