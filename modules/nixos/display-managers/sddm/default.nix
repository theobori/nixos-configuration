{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.display-managers.sddm;
in
{
  options.display-managers.sddm = {
    enable = lib.mkEnableOption "Enable SDDM";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;

      package = lib.mkForce pkgs.libsForQt5.sddm;

      extraPackages =
        with pkgs.libsForQt5;
        lib.mkForce [
          qt5.qtquickcontrols
          qt5.qtquickcontrols2
          qt5.qtgraphicaleffects
          qt5.qtdeclarative
          qt5.qtbase

          plasma-framework
          plasma-workspace
          plasma-integration
          kdeclarative
          plasma-desktop
        ];

      # Non-root X11 instance
      settings.General.DisplayServer = "x11-user";
      # My custom dracula theme
      theme = "sddm-dracula";
    };

    environment.systemPackages = with pkgs; [ theobori-org.sddm-dracula ];
  };
}
