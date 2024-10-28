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

  cfg = config.${namespace}.programs.qbittorrent;
in
{
  options.${namespace}.programs.qbittorrent = {
    enable = mkBoolOpt false "Whether or not to manage qbittorrent.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ qbittorrent ]; };
}
