{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf types optionalString;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.desktops.addons.plasma6;
  wallpaper = pkgs.${namespace}.wallpapers.nix-simple;
in
{
  options.${namespace}.desktops.addons.plasma6 = with types; {
    enable = mkBoolOpt false "Whether or not to enable GNOME addons.";
    extraWorkspace = mkOpt attrs {
      colorScheme = "DraculaPurple";
      theme = "Dracula";
      #lookAndFeel = "Dracula";

      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Dracula";
      };

      splashScreen = {
        theme = "";
      };

      cursor = {
        theme = "Dracula-cursors";
      };

      #iconTheme = "Dracula";

      inherit wallpaper;
    } "Extra configuration for the workspace plasma-manager module.";

    kscreenlocker = mkOpt attrs {
      appearance = {
        inherit wallpaper;
      };
    } "kscreenlocker plasma-manager module configuration.";

    widgets = mkOpt (listOf anything) [
      {
        kickoff = {
          sortAlphabetically = true;
          icon = "nix-snowflake-white";
        };
      }
      {
        iconTasks = {
          launchers = [
            "applications:systemsettings.desktop"

            (optionalString config.${namespace}.cli.terminals.kitty.enable "applications:kitty.desktop")
            (optionalString config.${namespace}.browsers.floorp.enable "applications:floorp.desktop")
            (optionalString config.${namespace}.messages.discord.enable "applications:vesktop.desktop")
            (optionalString config.${namespace}.editors.emacs.enable "applications:emacs.desktop")
            (optionalString config.${namespace}.programs.spicetify.enable "applications:spotify.desktop")
            (optionalString config.${namespace}.multimedia.tauon.enable "applications:tauonmb.desktop")

            # Wrong file naming upstream side
            (optionalString config.${namespace}.messages.ayugram.enable
              "applications:com.ayugram.desktop.desktop"
            )

            (optionalString config.${namespace}.games.taterclient-ddnet.enable
              "applications:taterclient-ddnet.desktop"
            )
            (optionalString config.${namespace}.programs.quake-injector.enable
              "applications:quake-injector.desktop"
            )
          ];
        };
      }
      "org.kde.plasma.marginsseparator"
      {
        systemTray.items = {
          shown = [
            "org.kde.plasma.battery"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.luminosity"
            "org.kde.plasma.bluetooth"
            "org.kde.plasma.networkmanagement"
            "org.kde.plasma.volume"
          ];
        };
      }
      {
        digitalClock = {
          calendar.firstDayOfWeek = "monday";
          time.format = "24h";
        };
      }
    ] "List of panel widgets.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.${namespace}.my-dracula-theme
      pkgs.dracula-icon-theme
    ];

    stylix = {
      # Generate impure (not managed by nix) gtk files because it is using Qt
      targets.gtk.enable = false;
      # Trying to apply the wallpaper too early and then it doest not load the home-manager environment
      targets.kde.enable = false;
    };

    programs.plasma = {
      enable = true;

      workspace = {
        enableMiddleClickPaste = true;
      }
      // cfg.extraWorkspace;

      inherit (cfg) kscreenlocker;

      panels = [
        {
          location = "bottom";
          inherit (cfg) widgets;
        }
      ];
    };
  };
}
