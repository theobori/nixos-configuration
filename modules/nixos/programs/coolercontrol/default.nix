{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.coolercontrol;
in
{
  options.${namespace}.programs.coolercontrol = {
    enable = mkBoolOpt false "Whether or not to manage coolercontrol.";
  };

  config = mkIf cfg.enable {
    programs.coolercontrol = {
      enable = true;
    };
  };
}
