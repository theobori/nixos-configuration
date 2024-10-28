{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bitwarden;
in
{
  options.programs.bitwarden = {
    enable = lib.mkEnableOption "Whether or not to manage bitwarden";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ bitwarden ]; };
}
