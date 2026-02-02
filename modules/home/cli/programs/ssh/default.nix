{
  inputs,
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

  cfg = config.${namespace}.cli.programs.ssh;
  sopsFile = "${inputs.my-secrets}/secrets/${host}/${user.name}/secrets.yaml";
  sopsEnable = config."${namespace}".services.sops.enable && cfg.useSops;
in
{
  options.${namespace}.cli.programs.ssh = {
    enable = mkBoolOpt false "Whether or not to configure ssh support.";
    useSops = mkBoolOpt false "Whether or not to use SOPS.";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      includes = lib.optional sopsEnable config.sops.secrets.ssh_config.path;
    };

    sops.secrets = mkIf sopsEnable {
      ssh_key = {
        inherit sopsFile;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };

      ssh_config = {
        inherit sopsFile;
      };
    };
  };
}
