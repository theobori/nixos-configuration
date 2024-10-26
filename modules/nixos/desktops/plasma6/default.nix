{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktops.plasma6;
in
{
  options.desktops.plasma6 = {
    enable = lib.mkEnableOption "Enable KDE Plasma 6";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
  };
}
