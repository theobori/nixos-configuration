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

  cfg = config.${namespace}.roles.games;
in
{
  options.${namespace}.roles.games = {
    enable = mkBoolOpt false "Enable single games.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Teeworlds and Teeworlds based games
      teeworlds
      #ddnet
      taterclient-ddnet

      # Quake 1
      # vkquake
    ];
  };
}
