{ lib, config, ... }:
let
  cfg = config.cli.programs.home-manager;
in
{
  options.cli.programs.home-manager = {
    enable = lib.mkEnableOption "Whether or not to enable home-manager";
  };

  config = lib.mkIf cfg.enable {
    programs.home-manager = {
      enable = true;
    };
  };
}
