{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

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
        uutils-coreutils = enabled;
      };

      programs = {
        wine = disabled; # Will be enabled when available in binary cache
      };

      hardware = {
        networking = enabled;
      };

      services = {
        clamav = enabled;
      };

      styles.stylix = enabled;

      networking.stevenBlackHosts = enabled;
    };
  };
}
