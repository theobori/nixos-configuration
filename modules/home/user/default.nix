{ config, lib, ... }:
let
  cfg = config.theobori-org.user;
in
{
  options.theobori-org.user = {
    enable = lib.mkEnableOption "Whether to configure the user account";

    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = config.snowfallorg.user.name;
      description = "The user account name";
    };

    home = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "/home/${cfg.name}";
      description = "The user's home directory path";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = cfg.name != null;
            message = "theobori-org.user.name must be set";
          }
        ];

        home = {
          homeDirectory = lib.mkDefault cfg.home;
          username = lib.mkDefault cfg.name;
        };
      }
    ]
  );
}
