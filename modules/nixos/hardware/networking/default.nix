{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = {
    enable = mkBoolOpt false "Enable networkmanager.";
  };

  config = mkIf cfg.enable {
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

    networking.networkmanager = enabled;
  };
}
