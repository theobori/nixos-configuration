{
  options,
  config,
  lib,
  ...
}:
let
  cfg = config.system.locale;
in
{
  options.system.locale = {
    enable = lib.mkEnableOption "Whether or not to manage locale settings";
  };

  config = lib.mkIf cfg.enable {
    i18n = {
      defaultLocale = lib.mkDefault "fr_FR.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
      };
    };

    time.timeZone = "Europe/Paris";

    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "fr";
      xkb.variant = "";
    };
    # Configure console keymap
    console.keyMap = "fr";
  };
}
