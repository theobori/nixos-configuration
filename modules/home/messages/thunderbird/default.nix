{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.messages.thunderbird;
in
{
  options.messages.thunderbird = {
    enable = lib.mkEnableOption "Whether or not to manage thunderbird";

    enableEmailAccounts = lib.mkEnableOption "Whether or not to enable email accounts";

    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = config.snowfallorg.user.name;
      description = "The thunderbird default profile name";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      profiles."${cfg.name}" = {
        isDefault = true;
      };
    };

    accounts.email.accounts = lib.mkIf cfg.enableEmailAccounts {

    };
  };
}
