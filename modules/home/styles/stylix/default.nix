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

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/03c6c20be96c38827037d2238357f2c777ec4aa5/wallpapers/nix-wallpaper-dracula.png";
        sha256 = "sha256-SykeFJXCzkeaxw06np0QkJCK28e0k30PdY8ZDVcQnh4=";
      };

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
          package = pkgs.inconsolata;
          name = "Inconsolata";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
