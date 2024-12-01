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

  cfg = config.${namespace}.cli.programs.xclip;
in
{
  options.${namespace}.cli.programs.xclip = {
    enable = mkBoolOpt false "Whether or not to enable xclip.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ xclip ]; };
}
