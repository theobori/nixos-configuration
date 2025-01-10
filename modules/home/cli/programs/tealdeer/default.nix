{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.tealdeer;
in
{
  options.${namespace}.cli.programs.tealdeer = {
    enable = mkBoolOpt false "Whether or not to enable tealdeer.";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        updates.auto_update = true;
      };
    };
  };
}
