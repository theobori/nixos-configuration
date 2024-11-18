{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.fastfetch;
in
{
  options.${namespace}.cli.programs.fastfetch = {
    enable = mkBoolOpt false "Whether or not to enable fastfetch.";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
}
