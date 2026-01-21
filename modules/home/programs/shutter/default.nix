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

  cfg = config.${namespace}.programs.shutter;
in
{
  options.${namespace}.programs.shutter = {
    enable = mkBoolOpt false "Whether or not to manage shutter.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ shutter ]; };
}
