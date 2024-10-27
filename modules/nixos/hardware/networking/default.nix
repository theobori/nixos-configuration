{ config, lib, ... }:
let
  cfg = config.hardware.networking;
in
{
  options.hardware.networking = {
    enable = lib.mkEnableOption "Enable networkmanager";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };

    networking.networkmanager.enable = true;
  };
}
