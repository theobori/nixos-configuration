{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.multimedia.calibre;
in
{
  options.multimedia.calibre = {
    enable = lib.mkEnableOption "Whether or not to manage calibre";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ calibre ]; };
}
