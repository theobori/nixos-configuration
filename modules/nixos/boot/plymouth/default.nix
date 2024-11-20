{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.boot.plymouth;
in
{
  options.${namespace}.boot.plymouth = {
    enable = mkBoolOpt false "Whether or not to enable plymouth.";
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
    };
  };
}
