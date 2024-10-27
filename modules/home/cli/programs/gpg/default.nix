{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.gpg;
in
{
  options.cli.programs.gpg = {
    enable = lib.mkEnableOption "Whether or not to enable gpg";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ kleopatra ];

    services.gnome-keyring.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      #sshKeys = [ "D528D50F4E9F031AACB1F7A9833E49C848D6C90" ];
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    programs = {
      gpg = {
        enable = true;
      };
    };
  };
}
