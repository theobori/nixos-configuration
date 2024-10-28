{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.hardware.bluetoothctl;
in
{
  options.${namespace}.hardware.bluetoothctl = {
    enable = mkBoolOpt false "Enable bluetooth service and packages.";
  };

  config = mkIf cfg.enable {
    services.blueman = enabled;
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
