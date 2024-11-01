{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.addons.plasma6;
in
{
  options.${namespace}.desktops.addons.plasma6 = with types; {
    enable = mkBoolOpt false "Whether or not to enable GNOME addons.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.${namespace}.my-dracula-theme ];

    stylix = {
      # Generate impure (not managed by nix) gtk files
      targets.gtk.enable = false;
      # Trying to apply the wallpaper too early and then it doest not load the home-manager environment
      targets.kde.enable = false;
    };

    programs.plasma = {
      enable = true;

      workspace = {
        colorScheme = "Dracula";
        theme = "Dracula";

        wallpaper = pkgs.${namespace}.wallpapers.nix-simple;

        enableMiddleClickPaste = true;
      };
    };
  };
}
