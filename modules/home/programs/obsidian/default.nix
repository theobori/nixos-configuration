{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.obsidian;
in
{
  options.programs.obsidian = {
    enable = lib.mkEnableOption "Whether or not to manage obsidian";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ obsidian ]; };
}
