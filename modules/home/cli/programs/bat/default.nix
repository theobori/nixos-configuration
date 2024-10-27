{ config, lib, ... }:
let
  cfg = config.cli.programs.bat;
in
{
  options.cli.programs.bat = {
    enable = lib.mkEnableOption "Whether or not to enable bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
