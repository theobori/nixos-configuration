{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.browsers.lagrange;
in
{
  options.browsers.lagrange = {
    enable = lib.mkEnableOption "Whether or not to manage lagrange";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ lagrange ]; };
}
