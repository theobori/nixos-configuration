{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.i3;
in
{
  options.${namespace}.desktops.i3 = {
    enable = mkBoolOpt false "Enable i3.";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
        ];
      };
    };
  };
}
