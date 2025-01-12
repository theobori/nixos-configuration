{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.flameshot;
in
{
  options.${namespace}.services.flameshot = {
    enable = mkBoolOpt false "Whether to enable flameshot.";
  };

  config = mkIf cfg.enable {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
        };
      };
    };
  };
}
