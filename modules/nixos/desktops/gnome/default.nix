{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.desktops.gnome;

  defaultExtensions = with pkgs.gnomeExtensions; [
    appindicator
    aylurs-widgets
    dash-to-dock
    gsconnect
    gtile
    just-perfection
    logo-menu
    no-overview
    remove-app-menu
    space-bar
    top-bar-organizer
    wireless-hid
  ];

in
{
  options.${namespace}.desktops.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to use Gnome as the desktop environment.";
    extensions = mkOpt (listOf package) [ ] "Extra Gnome extensions to install.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages =
        with pkgs;
        [
          gnome-tweaks
          nautilus-python
          wl-clipboard
        ]
        ++ defaultExtensions
        ++ cfg.extensions;

      gnome.excludePackages = with pkgs; [
        epiphany
        geary
        gnome-font-viewer
        gnome-maps
        gnome-system-monitor
        gnome-tour
      ];
    };

    # Required for app indicators
    services = {
      udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
      libinput.enable = true;

      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };
}
