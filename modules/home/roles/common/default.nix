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
    enable = mkBoolOpt false "Enable common configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      browsers = {
        firefox = enabled;
        librewolf = enabled;
        lagrange = enabled;
      };

      programs.bitwarden = enabled;

      system = {
        nix = enabled;
      };

      cli = {
        terminals.wezterm = enabled;
        shells.fish = enabled;
        programs = {
          home-manager = enabled;
          dua = enabled;
          killall = enabled;
          file-tools = enabled;
          xclip = enabled;
          manix = enabled;
          knock = enabled;
          sshs = enabled;
        };
      };

      styles.stylix = enabled;
    };
  };
}
