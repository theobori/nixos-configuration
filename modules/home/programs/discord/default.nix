{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.discord;
in
{
  options.programs.discord = {
    enable = lib.mkEnableOption "Whether or not to manage discord";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ goofcord ]; };
}
