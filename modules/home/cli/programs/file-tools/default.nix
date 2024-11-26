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

  cfg = config.${namespace}.cli.programs.file-tools;
in
{
  options.${namespace}.cli.programs.file-tools = {
    enable = mkBoolOpt false "Whether or not to enable file-tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      file
      mediainfo
      mediainfo-gui
    ];
  };
}
