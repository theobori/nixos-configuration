{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.styles.stylix;
  my-base16-schemes = pkgs.${namespace}.my-base16-schemes;
in
{
  options.${namespace}.styles.stylix = with types; {
    enable = mkBoolOpt false "Enable stylix.";
    image = mkOpt str (builtins.toString pkgs.${namespace}.wallpapers.talulah) "A wallpaper filepath.";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${my-base16-schemes}/share/themes/dracula.yaml";

      inherit (cfg) image;

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
