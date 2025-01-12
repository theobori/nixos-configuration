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

  cfg = config.${namespace}.multimedia.pavucontrol;
in
{
  options.${namespace}.multimedia.pavucontrol = {
    enable = mkBoolOpt false "Whether or not to manage pavucontrol.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ pavucontrol ]; };
}
