{
  pkgs,
  inputs,
  config,
  lib,
  namespace,
  host,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.accounts.email;
in
{
  options.${namespace}.accounts.email = with types; {
    enable = mkBoolOpt false "Whether or not to manage email.";
    packages = mkOpt (listOf package) (with pkgs; [
      age
      yq
    ]) "Needed Nix packages for the accounts configuration.";
    accounts = mkOpt attrs {
      disroot = {
        address = "theobori@disroot.org";
        gpg = {
          key = "063656A56E315FFDBE4685226D22B0682CCF9294";
          signByDefault = false;
        };
        imap = {
          host = "disroot.org";
          port = 993;
          tls.enable = true;
          authentication = "login";
        };
        smtp = {
          host = "disroot.org";
          port = 465;
          tls.enable = true;
          authentication = "login";
        };
        mbsync = {
          enable = true;
          create = "maildir";
        };
        msmtp.enable = true;
        notmuch.enable = true;
        primary = true;
        realName = "Théo Bori";
        passwordCommand = "age -i ${config.home.homeDirectory}/.config/sops/age/keys.txt -d ${inputs.my-secrets}/secrets/${host}/theobori/accounts-email.yaml.age | yq .accounts.disroot.theobori.password";
        userName = "theobori";
      };

      tilde-team = {
        address = "nagi@tilde.team";
        imap = {
          host = "imap.tilde.team";
          port = 993;
          tls.enable = true;
          authentication = "login";
        };
        smtp = {
          host = "smtp.tilde.team";
          port = 465;
          tls.enable = true;
          authentication = "login";
        };
        mbsync = {
          enable = true;
          create = "maildir";
        };
        msmtp.enable = true;
        notmuch.enable = true;
        realName = "Nagi";
        passwordCommand = "age -i ${config.home.homeDirectory}/.config/sops/age/keys.txt -d ${inputs.my-secrets}/secrets/${host}/theobori/accounts-email.yaml.age | yq .accounts.tilde_team.nagi.password";
        userName = "nagi";
      };
    } "Email accounts.";
  };

  config = mkIf cfg.enable {
    accounts.email = {
      inherit (cfg) accounts;
    };

    home = {
      inherit (cfg) packages;
    };
  };
}
