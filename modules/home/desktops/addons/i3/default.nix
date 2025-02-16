{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.desktops.addons.i3;
in
# wallpaper = pkgs.${namespace}.wallpapers.nix-simple;
{
  options.${namespace}.desktops.addons.i3 = with types; {
    enable = mkBoolOpt false "Whether or not to enable i3 addons.";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
    };
  };
}
