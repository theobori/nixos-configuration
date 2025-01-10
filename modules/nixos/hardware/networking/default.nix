{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable networkmanager.";
    insertNameservers = mkOpt (listOf str) [
      # Cloudflare
      "1.1.1.1"
      "1.0.0.1"
      # Google
      "8.8.8.8"
      "8.8.4.4"
    ] "Insert nameservers before the ones added by networkmanager";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;

        inherit (cfg) insertNameservers;
      };

      firewall = {
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
    };
  };
}
