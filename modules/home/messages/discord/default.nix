{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.messages.discord;
in
{
  options.${namespace}.messages.discord = {
    enable = mkBoolOpt false "Whether or not to manage discord.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ goofcord ]; };
}
