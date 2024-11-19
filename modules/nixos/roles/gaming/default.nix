{
  lib,
  config,
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
    enable = mkBoolOpt false "Enable gaming configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      programs = {
        steam = enabled;
      };
    };
  };
}
