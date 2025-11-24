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

  cfg = config.${namespace}.messages.element-desktop;
in
{
  options.${namespace}.messages.element-desktop = {
    enable = mkBoolOpt false "Whether or not to manage Element.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ element-desktop ]; };
}
