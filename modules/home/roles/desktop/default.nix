{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

  cfg = config.${namespace}.roles.desktop;
in
{
  options.${namespace}.roles.desktop = {
    enable = mkBoolOpt false "Enable desktop suite.";
  };

  config = mkIf cfg.enable {
    # Fixes tray icons: https://github.com/nix-community/home-manager/issues/2064#issuecomment-887300055
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };

    ${namespace} = {
      roles = {
        common = enabled;
        development = enabled;
      };

      system = {
        xdg-utils = enabled;
      };

      services = {
        flameshot = enabled;
      };

      cli = {
        programs = {
          fast-anime = enabled;
          xkill = enabled;
        };
        terminals = {
          syncterm = enabled;
          kitty = enabled;
        };
      };

      multimedia = {
        mpv = enabled;
        calibre = enabled;
        pavucontrol = enabled;
        pamixer = enabled;
        resonance = enabled;
      };

      programs = {
        inkscape = enabled;
        obsidian = enabled;
        qbittorrent = enabled;
        spicetify = disabled;
        quake-injector = enabled;
        pablodraw = enabled;
        libreoffice = enabled;
      };
    };
  };
}
