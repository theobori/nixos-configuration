{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.styles.stylix;
in
{
  imports = with inputs; [ stylix.homeManagerModules.stylix ];

  options.styles.stylix = {
    enable = lib.mkEnableOption "Enable stylix";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

      targets.gtk.enable = false;

      image = pkgs.theobori-org.wallpapers.nix-simple;

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
          package = pkgs.theobori-org.monolisa;
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
