{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.network-tools;
in
{
  options.cli.programs.network-tools = {
    enable = lib.mkEnableOption "Whether or not to enable network tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      termshark
      kubeshark
      wireshark
    ];
  };
}
