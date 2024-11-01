{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.security.doas;
in
{
  options.${namespace}.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = mkIf cfg.enable {
    # Disable sudo
    security.sudo.enable = false;

    # Enable and configure `doas`
    security.doas = {
      enable = true;
      extraRules = [
        {
          users = [ config.${namespace}.user.name ];
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
