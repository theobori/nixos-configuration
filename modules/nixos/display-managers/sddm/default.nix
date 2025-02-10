{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.display-managers.sddm;
in
{
  options.${namespace}.display-managers.sddm = {
    enable = mkBoolOpt false "Enable SDDM.";
  };

  config = mkIf cfg.enable {
    services.xserver = enabled;

    services.displayManager = {
      sddm = {
        enable = true;
      };
    };
  };
}
