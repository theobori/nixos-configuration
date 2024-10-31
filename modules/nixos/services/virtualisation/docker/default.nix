{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.virtualisation.docker;
in
{
  options.${namespace}.services.virtualisation.docker = {
    enable = mkBoolOpt false "Enable docker virtualisation.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ docker-compose ];

    virtualisation = {
      docker = {
        enable = true;

        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
    };
  };
}
