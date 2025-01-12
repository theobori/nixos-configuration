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

  cfg = config.${namespace}.cli.programs.xkill;
in
{
  options.${namespace}.cli.programs.xkill = {
    enable = mkBoolOpt false "Whether or not to enable xkill.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xorg.xkill ]; };
}
