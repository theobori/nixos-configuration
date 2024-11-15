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
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.cli.programs.age;
in
{
  options.${namespace}.cli.programs.age = {
    enable = mkBoolOpt false "Whether or not to enable age.";
    useSops = mkBoolOpt false "Whether or not to use SOPS.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ age ];

    sops.secrets = mkIf (config."${namespace}".services.sops.enable && cfg.useSops) {
      age_keys = {
        sopsFile = lib.snowfall.fs.get-file "secrets/${host}/${user.name}/secrets.yaml";
        path = "${config.home.homeDirectory}/sops/age/keys.txt";
      };
    };
  };
}
