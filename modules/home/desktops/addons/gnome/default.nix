{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf types mkForce;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.desktops.addons.gnome;
  default-attrs = lib.mapAttrs (_name: lib.mkDefault);
  nested-default-attrs = lib.mapAttrs (_name: default-attrs);
in
{
  options.${namespace}.desktops.addons.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable GNOME addons.";
    extraPackages = mkOpt (listOf package) (with pkgs; [
      fragments
      keypunch
      pkgs.${namespace}.my-dracula-theme
      dracula-icon-theme
    ]) "Extra packages to install.";
    extensions = mkOpt (listOf package) (with pkgs.gnomeExtensions; [
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
    ]) "List of gnome extensions";

    settings = mkOpt attrs (nested-default-attrs {
      "org/gnome/shell" = {
        enabled-extensions = (map (extension: extension.extensionUuid) cfg.extensions) ++ [
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];

        disabled-extensions = [ ];
        disable-user-extensions = false;
        favorite-apps =
          lib.optional config.${namespace}.cli.terminals.kitty.enable "kitty.desktop"
          ++ lib.optional config.${namespace}.browsers.firefox.enable "firefox.desktop"
          ++ lib.optional config.${namespace}.messages.discord.enable "vesktop.desktop"
          ++ lib.optional config.${namespace}.editors.emacs.enable "emacs.desktop"
          ++ lib.optional config.${namespace}.programs.spicetify.enable "spotify.desktop"
          ++ lib.optional config.${namespace}.multimedia.tauon.enable "tauonmb.desktop"
          ++ lib.optional config.${namespace}.games.taterclient-ddnet.enable "taterclient-ddnet.desktop"
          ++ lib.optional config.${namespace}.programs.quake-injector.enable "quake-injector.desktop";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
        resize-with-right-button = true;
        theme = "Dracula";
      };

      "gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        natural-scroll = false;
        speed = 0.9;
      };

      "gnome/desktop/peripherals/touchpad" = {
        edge-scrolling-enabled = false;
        natural-scroll = false;
        two-finger-scrolling-enabled = true;
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

        show-screenshot-ui = [ "<Shift><Super>s" ];
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

        show-screenshot-ui = [ "<Shift><Super>s" ];
      };

      "org/gnome/desktop/interface" = {
        # Is overrided by Stylix
        font-name = "Adwaita Sans 11";
        enable-hot-corners = false;
      };

      "org/gtk/settings/file-chooser" = {
        sort-directories-first = true;
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.85;
        dash-opacity = 0.25;
        sigma = 15;
        static-blur = true;
      };

      "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
        tweak-kitty-terminal = true;
      };

      "org/gnome/shell/extensions/Logo-menu" = {
        hide-softwarecentre = true;

        menu-button-icon-click-type = 3;
        menu-button-icon-image = 23;
        symbolic-icon = true;
        use-custom-icon = false;
      };

      "org/gnome/shell/extensions/top-bar-organizer" = {
        left-box-order = [
          "LogoMenu"
          "Space Bar"
        ];

        center-box-order = [ "dash" ];

        right-box-order = [
          "dateMenu"
          "gTile@vibou"
          "Clipboard History Indicator"
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

      "org/gnome/shell/extensions/dash-in-panel" = {
        button-margin = 4;
        center-dash = false;
        dim-dot = true;
        icon-size = 32;
        panel-height = 37;
        show-apps = false;
        show-dash = false;
        show-label = false;
        show-running = false;
      };

      "org/gnome/shell/extensions/space-bar/shortcuts" = {
        enable-activate-workspace-shortcuts = false;
      };

      "org/gnome/shell/extensions/space-bar/behavior" = {
        show-empty-workspaces = true;
      };
    }) "Manage the dconf settings.";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        gnome-tweaks
      ]
      ++ cfg.extraPackages;

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };

    stylix.fonts.sansSerif = mkForce {
      name = "Adwaita Sans";
      package = pkgs.adwaita-fonts;
    };

    stylix.fonts.sizes = mkForce {
      terminal = 11;
      applications = 11;
      popups = 12;
    };

    dconf = {
      enable = true;

      inherit (cfg) settings;
    };
  };
}
