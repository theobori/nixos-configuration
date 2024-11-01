{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.desktops.addons.gnome;
in
{
  options.${namespace}.desktops.addons.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable GNOME addons.";
    settings = mkOpt attrs {
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];

        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
      };

      "org/gnome/shell/keybindings" = {
        # Remove the default hotkeys for opening favorited applications.
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        switch-to-application-10 = [ ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        autohide = true;
        dock-fixed = false;
        dock-position = "BOTTOM";
        pressure-threshold = 200.0;
        require-pressure-to-show = true;
        show-favorites = true;
        hot-keys = false;
      };

      "org/gnome/shell/extensions/just-perfection" = {
        panel-size = 48;
        activities-button = false;
      };

      "org/gnome/shell/extensions/Logo-menu" = {
        hide-softwarecentre = true;

        # Use right click to open Activities.
        menu-button-icon-click-type = 3;

        # Use the NixOS logo.
        menu-button-icon-image = 23;
      };

      "org/gnome/shell/extensions/aylurs-widgets" = {
        background-clock = false;
        battery-bar = false;
        dash-board = false;
        date-menu-date-format = "%H:%M  %B %m";
        date-menu-hide-clocks = true;
        date-menu-hide-system-levels = true;
        date-menu-hide-user = true;

        # Hide the indincator
        date-menu-indicator-position = 2;

        media-player = false;
        media-player-prefer = "firefox";
        notification-indicator = false;
        power-menu = false;
        quick-toggles = false;
        workspace-indicator = false;
      };

      "org/gnome/shell/extensions/top-bar-organizer" = {
        left-box-order = [
          "menuButton"
          "activities"
          "dateMenu"
          "appMenu"
        ];

        center-box-order = [ "Space Bar" ];

        right-box-order = [
          "keyboard"
          "EmojisMenu"
          "wireless-hid"
          "drive-menu"
          "vitalsMenu"
          "screenRecording"
          "screenSharing"
          "dwellClick"
          "a11y"
          "quickSettings"
        ];
      };

      "org/gnome/shell/extensions/space-bar/shortcuts" = {
        enable-activate-workspace-shortcuts = false;
      };

      "org/gnome/shell/extensions/space-bar/behavior" = {
        show-empty-workspaces = false;
      };
    } "Manage the dconf settings.";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      inherit (cfg) settings;
    };
  };
}
