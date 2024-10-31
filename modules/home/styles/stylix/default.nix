{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.styles.stylix;
in
{
  options.${namespace}.styles.stylix = {
    enable = mkBoolOpt false "Enable stylix.";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      # autoenable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

      targets.gtk.enable = false;

      image = pkgs.${namespace}.wallpapers.nix-simple;

      fonts = {
        sizes = {
          terminal = 11;
          applications = 12;
          popups = 12;
        };

        serif = {
          name = "Source Serif";
          package = pkgs.source-serif;
        };

        sansSerif = {
          name = "Noto Sans";
          package = pkgs.noto-fonts;
        };

        monospace = {
          package = pkgs.${namespace}.monolisa;
          name = "MonoLisa Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
