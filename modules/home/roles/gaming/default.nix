{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.roles.gaming;
in
{
  options.${namespace}.roles.gaming = {
    enable = mkBoolOpt false "Enable gaming.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      games = {
        teeworlds = enabled;
        taterclient-ddnet = enabled;
      };
    };
  };
}