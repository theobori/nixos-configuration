{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.games.sober;
in
{
  options.${namespace}.games.sober = {
    enable = mkBoolOpt false "Enable sober.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      services.flatpak.packages = [ ":${./sober.flatpakref}" ];
    };
  };
}
