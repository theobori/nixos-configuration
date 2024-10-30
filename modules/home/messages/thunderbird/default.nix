{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.messages.thunderbird;
in
{
  options.${namespace}.messages.thunderbird = with types; {
    enable = mkBoolOpt false "Whether or not to manage thunderbird.";
    name = mkOpt str config.${namespace}.user.name "The thunderbird default profile name";
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      profiles."${cfg.name}" = {
        isDefault = true;
      };
    };
  };
}
