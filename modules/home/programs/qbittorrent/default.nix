{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.qbittorrent;
in
{
  options.programs.qbittorrent = {
    enable = lib.mkEnableOption "Whether or not to manage qbittorrent";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ qbittorrent ]; };
}
