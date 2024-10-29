{
  config,
  lib,
  inputs,
  pkgs,
  namespace,
  host,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.cli.programs.ssh;
in
{
  options.${namespace}.cli.programs.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure ssh support.";
    extraConfig = mkOpt str "" "Extra configuration to apply.";
    useSops = mkBoolOpt false "Whether or not to use SOPS.";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      inherit (cfg) extraConfig;
    };

    sops.secrets = mkIf (config."${namespace}".services.sops.enable && cfg.useSops) {
      "vm_theobori_ssh_key" = {
        sopsFile = lib.snowfall.fs.get-file "secrets/${host}/${user.name}/secrets.yaml";
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
}
