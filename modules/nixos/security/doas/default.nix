{ config, lib, ... }:
let
  cfg = config.security.theobori-org.doas;
in
{
  options.security.theobori-org.doas = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether or not to replace sudo with doas";
    };
  };

  config = lib.mkIf cfg.enable {
    # Disable sudo
    security.sudo.enable = false;

    # Enable and configure `doas`
    security.doas = {
      enable = true;
      extraRules = [
        {
          users = [ config.user.name ];
          noPass = false;
          keepEnv = true;
        }
      ];
    };

    # Add an alias to the shell for backward-compat and convenience
    environment.shellAliases = {
      sudo = "doas";
    };
  };
}
