{ lib, config, ... }:
with lib;
let
  cfg = config.roles.development;
in
{
  options.roles.development = {
    enable = mkEnableOption "Enable development configuration";
  };

  config = lib.mkIf cfg.enable {
    cli = {
      multiplexers.tmux.enable = true;

      programs = {
        bat.enable = true;
        direnv.enable = true;
        eza.enable = true;
        fzf.enable = true;
        git.enable = true;
        gpg.enable = true;
        htop.enable = true;
        btop.enable = true;
        k8s.enable = true;
        terraform.enable = true;
        modern-unix.enable = true;
        network-tools.enable = true;
        nix-index.enable = true;
        ssh.enable = true;
        starship.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
        thefuck.enable = true;
      };
    };
  };
}
