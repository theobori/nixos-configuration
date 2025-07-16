{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.gnome;
in
{
  options.${namespace}.desktops.gnome = {
    enable = mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      nautilus-python
      wl-clipboard
      pkgs.${namespace}.my-dracula-theme
      dracula-icon-theme
    ];

    programs.dconf.enable = true;

    services = {
      udev.packages = [ pkgs.gnome-settings-daemon ];
      libinput.enable = true;

      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };
}
