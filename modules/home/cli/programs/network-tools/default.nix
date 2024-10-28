{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.network-tools;
in
{
  options.${namespace}.cli.programs.network-tools = {
    enable = mkBoolOpt false "Whether or not to enable network tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      termshark
      kubeshark
      wireshark
    ];
  };
}
