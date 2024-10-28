{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.inkscape;
in
{
  options.programs.inkscape = {
    enable = lib.mkEnableOption "Whether or not to manage inkscape";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ inkscape ]; };
}
