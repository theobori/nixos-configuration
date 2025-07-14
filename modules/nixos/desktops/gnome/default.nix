{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.gnome;
in
{
  options.${namespace}.desktops.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        gnome-tweaks
        nautilus-python
        wl-clipboard
        pkgs.${namespace}.my-dracula-theme
        dracula-icon-theme
      ]
      ++ (with pkgs.gnomeExtensions; [
        logo-menu
        no-overview
        space-bar
        top-bar-organizer
        wireless-hid
        blur-my-shell
        rounded-window-corners-reborn
        clipboard-history
        gtile
        dash-in-panel
        pkgs.${namespace}.my-remove-clock
        pkgs.${namespace}.gnome-ext-hanabi
      ]);

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
