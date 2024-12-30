{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.roles.common;
in
{
  options.${namespace}.roles.common = {
    enable = mkBoolOpt false "Enable common configuration";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      system = {
        nix = enabled;
        locale = enabled;
      };

      programs = {
        wine = enabled;
      };

      hardware = {
        networking = enabled;
      };

      styles.stylix = enabled;

      networking.stevenBlackHosts = enabled;
    };
  };
}
