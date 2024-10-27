{ lib, config, ... }:
let
  cfg = config.roles.common;
in
{
  options.roles.common = {
    enable = lib.mkEnableOption "Enable common configuration";
  };

  config = lib.mkIf cfg.enable {
    system = {
      nix.enable = true;
      locale.enable = true;
    };

    hardware = {
      networking.enable = true;
    };

    styles.stylix.enable = true;
  };
}
