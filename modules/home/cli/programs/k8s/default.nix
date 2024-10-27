{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.k8s;
in
{
  options.cli.programs.k8s = {
    enable = lib.mkEnableOption "Whether or not to manage kubernetes";
  };

  config = lib.mkIf cfg.enable {
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
