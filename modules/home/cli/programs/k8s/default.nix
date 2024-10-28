{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.k8s;
in
{
  options.${namespace}.cli.programs.k8s = {
    enable = mkBoolOpt false "Whether or not to manage kubernetes.";
  };

  config = mkIf cfg.enable {
    programs = {
      k9s = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      kubectl
      kubectx
      kubelogin
      kubelogin-oidc
      stern
      kubernetes-helm
    ];
  };
}
