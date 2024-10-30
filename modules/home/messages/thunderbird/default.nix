{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.messages.thunderbird;
in
{
  options.${namespace}.messages.thunderbird = with types; {
    enable = mkBoolOpt false "Whether or not to manage thunderbird.";
    name = mkOpt str user.name "The thunderbird default profile name";
    # TODO: Create an other module to manage email accounts, this module should only add the `thunderbird` key within each email accounts
    # For my use case, it works well because I only use Thunderbird as email client.
    accounts = mkOpt attrs {
      "tilde.team" = {
        realName = user.fullName;
        address = "nagi@tilde.team";
        userName = "nagi";
        primary = true;
        smtp = {
          host = "smtp.tilde.team";
          port = 465;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        thunderbird = {
          enable = true;
          profiles = [ user.name ];
        };
      };
    } "The thunderbird email accounts";
  };

  config = mkIf cfg.enable {
    accounts.email.accounts = cfg.accounts;

    programs.thunderbird = {
      enable = true;

      profiles."${cfg.name}" = {
        isDefault = true;
      };
    };
  };
}
