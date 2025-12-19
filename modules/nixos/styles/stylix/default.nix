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
  my-base16-schemes = pkgs.${namespace}.my-base16-schemes;
in
{
  options.${namespace}.styles.stylix = {
    enable = mkBoolOpt false "Enable stylix.";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${my-base16-schemes}/share/themes/dracula.yaml";

      homeManagerIntegration.autoImport = false;
      homeManagerIntegration.followSystem = false;

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
          name = "MonoLisa";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
