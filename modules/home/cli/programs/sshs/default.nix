{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.sshs;
in
{
  options.${namespace}.cli.programs.sshs = {
    enable = mkBoolOpt false "Whether or not to enable sshs.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ sshs ]; };
}
