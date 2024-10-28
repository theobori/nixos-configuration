{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.thefuck;
in
{
  options.${namespace}.cli.programs.thefuck = {
    enable = mkBoolOpt false "Whether or not to enable thefuck.";
  };

  config = mkIf cfg.enable {
    programs.thefuck = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
