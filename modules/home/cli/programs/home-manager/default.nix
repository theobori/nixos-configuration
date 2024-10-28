{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.home-manager;
in
{
  options.${namespace}.cli.programs.home-manager = {
    enable = mkBoolOpt false "Whether or not to enable home-manager.";
  };

  config = mkIf cfg.enable {
    programs.home-manager = {
      enable = true;
    };
  };
}
