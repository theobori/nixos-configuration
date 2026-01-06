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
      # keep-sorted start block=yes newline_separated=yes
      browsers = {
        firefox = enabled;
        floorp = enabled;
        librewolf = enabled;
        lagrange = enabled;
        gophie = enabled;
      };

      cli = {
        programs = {
          ratiomaster = enabled;
          xkill = enabled;
        };
        terminals = {
          syncterm = enabled;
          kitty = enabled;
        };
      };

      hardware = {
        razer = disabled;
      };

      multimedia = {
        mpv = enabled;
        calibre = enabled;
        pavucontrol = enabled;
        pamixer = enabled;
        resonance = disabled;
        tauon = enabled;
      };

      programs = {
        inkscape = enabled;
        cambalache = disabled;
        obsidian = enabled;
        qbittorrent = enabled;
        qdirstat = enabled;
        spicetify = disabled;
        pablodraw = enabled;
        libreoffice = enabled;
        localsend = enabled;
      };

      roles = {
        common = enabled;
        development = enabled;
      };

      services = {
        flameshot = enabled;
      };

      system = {
        xdg-utils = enabled;
      };
      # keep-sorted end block=yes
    };
  };
}
