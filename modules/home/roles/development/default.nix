{
  lib,
  config,
  namespace,
  ...
}:
with lib;
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.roles.development;
in
{
  options.${namespace}.roles.development = {
    enable = mkEnableOption "Enable development configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      editors = {
        vscode = enabled;
        emacs = enabled;
        code-cursor = enabled;
      };

      programs = {
        sqlitebrowser = enabled;
      };

      cli = {
        multiplexers.tmux = enabled;

        programs = {
          age = enabled;
          bat = enabled;
          direnv = enabled;
          eza = enabled;
          fzf = enabled;
          fastfetch = enabled;
          onefetch = enabled;
          git = enabled;
          git-cliff = enabled;
          gpg = enabled;
          htop = enabled;
          btop = enabled;
          k8s = enabled;
          terraform = enabled;
          modern-unix = enabled;
          network-tools = enabled;
          nsearch = enabled;
          nix-index = enabled;
          screen = enabled;
          ssh = enabled;
          starship = enabled;
          yazi = enabled;
          zoxide = enabled;
          thefuck = enabled;
          lazygit = enabled;
          tealdeer = enabled;
          krabby = enabled;
          genact = enabled;
          ratiomaster = enabled;
        };
      };
    };
  };
}
