{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.roles.games;
in
{
  options.roles.games = {
    enable = lib.mkEnableOption "Enable single games";
  };

  config = lib.mkIf cfg.enable {
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
