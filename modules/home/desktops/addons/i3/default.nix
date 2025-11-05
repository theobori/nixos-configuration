{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.addons.i3;
in
# wallpaper = pkgs.${namespace}.wallpapers.nix-simple;
{
  options.${namespace}.desktops.addons.i3 = {
    enable = mkBoolOpt false "Whether or not to enable i3 addons.";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
    };
  };
}
