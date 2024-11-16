{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.display-managers.sddm;
in
{
  options.${namespace}.display-managers.sddm = {
    enable = mkBoolOpt false "Enable SDDM.";
  };

  config = mkIf cfg.enable {
    services.xserver = enabled;

    services.displayManager.sddm = {
      enable = true;
      # package = mkForce pkgs.libsForQt5.sddm;
      # extraPackages =
      #   with pkgs.libsForQt5;
      #   mkForce [
      #     qt5.qtquickcontrols
      #     qt5.qtquickcontrols2
      #     qt5.qtgraphicaleffects
      #     qt5.qtdeclarative
      #     qt5.qtbase

      #     plasma-framework
      #     plasma-workspace
      #     plasma-integration
      #     kdeclarative
      #   ];

      # Non-root X11 instance
      # settings.General.DisplayServer = "x11-user";
      # My custom dracula theme
      # theme = "Dracula";
    };

    # environment.systemPackages = [ pkgs.${namespace}.my-dracula-theme ];
  };
}
