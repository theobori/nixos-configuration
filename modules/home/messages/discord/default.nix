{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.messages.discord;
in
{
  options.messages.discord = {
    enable = lib.mkEnableOption "Whether or not to manage discord";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ goofcord ]; };
}
