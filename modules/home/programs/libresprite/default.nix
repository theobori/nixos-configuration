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

  cfg = config.${namespace}.programs.libresprite;
in
{
  options.${namespace}.programs.libresprite = {
    enable = mkBoolOpt false "Whether or not to manage libresprite.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ libresprite ]; };
}
