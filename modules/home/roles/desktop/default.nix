{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.roles.desktop;
in
{
  options.roles.desktop = {
    enable = lib.mkEnableOption "Enable desktop suite";
  };

  config = lib.mkIf cfg.enable {
    roles = {
      common.enable = true;
      development.enable = true;
    };

    # Fixes tray icons: https://github.com/nix-community/home-manager/issues/2064#issuecomment-887300055
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };

    multimedia.mpv.enable = true;
    multimedia.calibre.enable = true;
    programs.inkscape.enable = true;
    programs.obsidian.enable = true;
    programs.qbittorrent.enable = true;

    home.packages = with pkgs; [
      spotify
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
    ];
  };
}
