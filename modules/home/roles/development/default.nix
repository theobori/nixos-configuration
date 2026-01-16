{
  lib,
  config,
  namespace,
  ...
}:
with lib;
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) enabled disabled;

  cfg = config.${namespace}.roles.development;
in
{
  options.${namespace}.roles.development = {
    enable = mkEnableOption "Enable development configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      # keep-sorted start block=yes newline_separated=yes
      cli = {
        multiplexers.tmux = enabled;

        programs = {
          # keep-sorted start block=yes
          age = enabled;
          bat = enabled;
          btop = enabled;
          direnv = enabled;
          eza = enabled;
          fastfetch = enabled;
          fzf = enabled;
          genact = enabled;
          git = enabled;
          git-cliff = enabled;
          gpg = enabled;
          htop = enabled;
          k8s = enabled;
          krabby = enabled;
          lazydocker = enabled;
          lazygit = enabled;
          modern-unix = enabled;
          network-tools = enabled;
          nix-converter = enabled;
          nix-index = enabled;
          nsearch = enabled;
          onefetch = enabled;
          pay-respects = enabled;
          screen = enabled;
          ssh = enabled;
          starship = enabled;
          tealdeer = enabled;
          terraform = enabled;
          yazi = enabled;
          zoxide = enabled;
          # keep-sorted end
        };
      };

      editors = {
        vscode = enabled;
        emacs = enabled;
        code-cursor = enabled;
        pycharm = disabled;
        gnome-builder = enabled;
      };

      programs = {
        sqlitebrowser = enabled;
      };
      # keep-sorted end
    };
  };
}
