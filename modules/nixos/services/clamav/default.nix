{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.clamav;
in
{
  options.${namespace}.services.clamav = {
    enable = mkBoolOpt false "Whether or not to replace sudo with clamav.";
  };

  config = mkIf cfg.enable {
    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };
}
