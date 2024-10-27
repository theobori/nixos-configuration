{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.terraform;
in
{
  options.cli.programs.terraform = {
    enable = lib.mkEnableOption "Whether or not to enable Terraform";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ terraform ]; };
}
