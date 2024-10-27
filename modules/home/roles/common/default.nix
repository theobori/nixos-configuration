{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.roles.common;
in
{
  options.roles.common = {
    enable = lib.mkEnableOption "Enable common configuration";
  };

  config = lib.mkIf cfg.enable {
    browsers.firefox.enable = true;

    system = {
      nix.enable = true;
    };

    cli = {
      terminals.wezterm.enable = true;
      shells.fish.enable = true;
    };

    styles.stylix.enable = true;
  };
}
