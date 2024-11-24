{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.eza;
in
{
  options.${namespace}.cli.programs.eza = {
    enable = mkBoolOpt false "Whether or not to enable eza.";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
    };
  };
}
