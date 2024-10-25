{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.browsers.firefox;
in
{
  options.browsers.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable firefox browser";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };

    programs.firefox = {
      enable = true;

      profiles.default = {
        name = "Default";

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          private-relay
          return-youtube-dislikes
          tab-stash
          stylus
          ublock-origin
        ];
      };
    };
  };
}
