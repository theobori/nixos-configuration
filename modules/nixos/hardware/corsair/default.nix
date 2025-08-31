{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.corsair;
in
{
  options.${namespace}.hardware.corsair = {
    enable = mkBoolOpt false "Enable CORSAIR open source driver.";
  };

  config = mkIf cfg.enable {
    hardware.ckb-next.enable = true;
  };
}
