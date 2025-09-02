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

  cfg = config.${namespace}.hardware.razer;
in
{
  options.${namespace}.hardware.razer = {
    enable = mkBoolOpt false "Whether to enable razer.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      openrazer-daemon
      polychromatic
    ];
  };
}
