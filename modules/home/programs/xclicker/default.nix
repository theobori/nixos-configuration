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

  cfg = config.${namespace}.programs.xclicker;
in
{
  options.${namespace}.programs.xclicker = {
    enable = mkBoolOpt false "Whether or not to manage xclicker.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xclicker ]; };
}
