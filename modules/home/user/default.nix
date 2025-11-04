{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib)
    types
    mkIf
    mkDefault
    mkMerge
    ;
  inherit (lib.${namespace}) mkOpt enabled;

  cfg = config.${namespace}.user;

  home-directory = if cfg.name == null then null else "/home/${cfg.name}";
in
{
  options.${namespace}.user = {
    enable = mkOpt types.bool false "Whether to configure the user account.";
    email = mkOpt types.str "theobori@disroot.org" "The email of the user.";
    fullName = mkOpt types.str "Théo Bori" "The full name of the user.";
    home = mkOpt (types.nullOr types.str) home-directory "The user's home directory.";
    name = mkOpt (types.nullOr types.str) config.snowfallorg.user.name "The user account.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "${namespace}.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "${namespace}.user.home must be set";
        }
      ];

      home = {
        homeDirectory = mkDefault cfg.home;
        username = mkDefault cfg.name;
      };

      ${namespace}.cli.programs.home-manager = enabled;
    }
  ]);
}
