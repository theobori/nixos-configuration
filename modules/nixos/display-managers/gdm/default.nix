{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.display-managers.gdm;
in
{
  options.${namespace}.display-managers.gdm = {
    enable = mkBoolOpt false "Enable gdm.";
    autoSuspend = mkBoolOpt true "Whether or not to suspend the machine after inactivity.";
    wayland = mkBoolOpt false "Whether or not to use Wayland.";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        inherit (cfg) wayland autoSuspend;
      };
    };
  };
}
