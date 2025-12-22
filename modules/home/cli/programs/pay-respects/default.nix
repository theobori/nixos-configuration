{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.pay-respects;
in
{
  options.${namespace}.cli.programs.pay-respects = {
    enable = mkBoolOpt false "Whether or not to enable pay-respects.";
  };

  config = mkIf cfg.enable {
    programs.pay-respects = {
      enable = true;
      enableFishIntegration = true; # Broken for some reasons
    };
  };
}
