{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.roles.desktop;
in
{
  options.${namespace}.roles.desktop = {
    enable = mkBoolOpt false "Enable desktop configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      roles = {
        common = enabled;
      };

      hardware = {
        audio = enabled;
        bluetoothctl = enabled;
      };

      cli.programs = {
        nh = enabled;
      };
    };
  };
}
