{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.multimedia.obs-studio;
in
{
  options.${namespace}.multimedia.obs-studio = {
    enable = mkBoolOpt false "Whether or not to manage obs-studio.";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
