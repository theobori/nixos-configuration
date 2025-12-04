{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.git-cliff;
in
{
  options.${namespace}.cli.programs.git-cliff = {
    enable = mkBoolOpt false "Whether or not to enable git-cliff.";
  };

  config = mkIf cfg.enable {
    programs.git-cliff = {
      enable = true;
    };
  };
}
