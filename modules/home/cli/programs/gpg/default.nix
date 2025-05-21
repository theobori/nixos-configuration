{
  pkgs,
  config,
  lib,
  namespace,
  host,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.cli.programs.gpg;
in
{
  options.${namespace}.cli.programs.gpg = {
    enable = mkBoolOpt false "Whether or not to enable gpg.";
    useSops = mkBoolOpt false "Whether or not to use SOPS.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kdePackages.kleopatra ];

    programs.gpg = enabled;

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
    };

    sops.secrets = mkIf (config."${namespace}".services.sops.enable && cfg.useSops) {
      pgp_key = {
        sopsFile = lib.snowfall.fs.get-file "secrets/${host}/${user.name}/secrets.yaml";
      };
    };
  };
}
