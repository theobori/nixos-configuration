{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.eza;
in
{
  options.cli.programs.eza = {
    enable = lib.mkEnableOption "Whether or not to enable eza";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
    };
  };
}
