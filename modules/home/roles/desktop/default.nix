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

    home.packages = with pkgs; [
      pavucontrol
      mplayer
      mtpfs
      jmtpfs
      brightnessctl
      xdg-utils
      wl-clipboard
      clipse
      pamixer
      playerctl
      flameshot
      grimblast
      slurp
      xorg.xkill
    ];

    ${namespace} = {
      roles = {
        common = enabled;
        development = enabled;
      };

      multimedia.mpv = enabled;
      multimedia.calibre = enabled;
      programs = {
        inkscape = enabled;
        obsidian = enabled;
        qbittorrent = enabled;
        spicetify = enabled;
      };
    };
  };
}
