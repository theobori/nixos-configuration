{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

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

    # TODO: Make modules for this packages
    home.packages = with pkgs; [
      brightnessctl
      xdg-utils
      clipse
      flameshot
      xorg.xkill
    ];

    ${namespace} = {
      roles = {
        common = enabled;
        development = enabled;
      };

      services.flatpak = enabled;

      cli = {
        programs.fast-anime = enabled;
        terminals = {
          syncterm = enabled;
          wezterm = enabled;
        };
      };

      multimedia = {
        mpv = enabled;
        calibre = enabled;
        pavucontrol = enabled;
        pamixer = enabled;
      };

      programs = {
        inkscape = enabled;
        obsidian = enabled;
        qbittorrent = enabled;
        spicetify = enabled;
        quake-injector = enabled;
        pablodraw = enabled;
      };
    };
  };
}
