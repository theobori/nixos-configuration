{ config, lib, ... }:
let
  cfg = config.hardware.bluetoothctl;
in
{
  options.hardware.bluetoothctl = {
    enable = lib.mkEnableOption "Enable bluetooth service and packages";
  };

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings = {
          General = {
            Experimental = true;
          };
        };
      };
    };
  };
}
