{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.filesystem;
in
{
  options.${namespace}.system.filesystem = {
    enable = mkBoolOpt false "Whether or not to manage filesystem.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mtpfs
      jmtpfs
    ];
  };
}
