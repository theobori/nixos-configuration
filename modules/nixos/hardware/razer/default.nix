{
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
    enable = mkBoolOpt false "Enable Razer open source driver.";
  };

  config = mkIf cfg.enable {
    hardware.openrazer.enable = true;
  };
}
