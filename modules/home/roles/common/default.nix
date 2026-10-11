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
    enable = mkBoolOpt false "Enable common configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      services = {
        lorri = enabled;
      };

      system = {
        filesystem = enabled;
        nix = enabled;
      };

      cli = {
        shells.fish = enabled;
        programs = {
          home-manager = enabled;
          dua = enabled;
          killall = enabled;
          file-tools = enabled;
          xclip = enabled;
          manix = enabled;
          knock = disabled; # Not needed for the moment
          sshs = enabled;
          mat = enabled;
          openssl = enabled;
          a = enabled;
          sacc = enabled;
        };
      };

      styles.stylix = enabled;
    };
  };
}
