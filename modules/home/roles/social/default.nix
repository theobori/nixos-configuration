{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.roles.social;
in
{
  options.${namespace}.roles.social = {
    enable = mkBoolOpt false "Enable social suite.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      messages = {
        discord = enabled;
        thunderbird = enabled;
        deltachat = enabled;
        dino = enabled;
        element-desktop = enabled;
        pidgin = enabled;
      };
    };
  };
}
