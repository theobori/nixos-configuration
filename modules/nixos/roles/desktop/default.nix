{ lib, config, ... }:
let
  cfg = config.roles.desktop;
in
{
  options.roles.desktop = {
    enable = lib.mkEnableOption "Enable desktop configuration";
  };

  config = lib.mkIf cfg.enable {
    roles = {
      common.enable = true;
    };

    hardware = {
      audio.enable = true;
      bluetoothctl.enable = true;
    };

    cli.programs = {
      nh.enable = true;
    };
  };
}
