{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.desktops.plasma6;
in
{
  options.${namespace}.desktops.plasma6 = {
    enable = mkBoolOpt false "Enable KDE Plasma 6.";
  };

  config = mkIf cfg.enable {
    services.xserver = enabled;

    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
  };
}
