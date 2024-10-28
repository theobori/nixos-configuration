{
  pkgs,
  lib,
  config,
  host,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.shells.fish;
in
{
  options.${namespace}.cli.shells.fish = {
    enable = mkBoolOpt false "Enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        # There are fish intregration from home-manager module
        ${pkgs.nix-your-shell}/bin/nix-your-shell --nom fish | source

        set -x GOPATH $XDG_DATA_HOME/go
        set -gx PATH /usr/local/bin /usr/bin ~/.local/bin $GOPATH/bin/ $PATH $HOME/.cargo/bin

        # fish_add_path --path --append $GOPATH/bin/
        # fish_add_path --path --append /usr/local/bin /usr/bin ~/.local/bin
      '';

      shellAbbrs = {
        la = "exa -lahg --git";
        li = "exa -lahg --git --icons";
        tmux = "tmux -2";
        tf = "terraform";
        k = "kubectl";
        s = "screen -d -m";
        emacs = "emacs -nw";
        d = "date +%Y-%m-%d";
        cd = "z";
        cdi = "zi";
        curl = "curlie";
        tree = "eza --tree";

        # nix
        nhh = "nh home switch";
        nho = "nh os switch";
        nhu = "nh os --update";

        nd = "nix develop";
        nfu = "nix flake update";
        hms = "home-manager switch --flake ~/${namespace}#${config.theobori-nix.user.name}@${host}";
        nrs = "sudo nixos-rebuild switch --flake ~/${namespace}#${host}";
      };

      functions = {
        fish_greeting = '''';

        hmg = ''
          set current_gen (home-manager generations | head -n 1 | awk '{print $7}')
          home-manager generations | awk '{print $7}' | tac | fzf --preview "echo {} | xargs -I % sh -c 'nvd --color=always diff $current_gen %' | xargs -I{} bash {}/activate"
        '';

        fish_command_not_found = ''
          # If you run the command with comma, running the same command
          # will not prompt for confirmation for the rest of the session
          if contains $argv[1] $__command_not_found_confirmed_commands
            or ${pkgs.gum}/bin/gum confirm --selected.background=2 "Run using comma?"

            # Not bothering with capturing the status of the command, just run it again
            if not contains $argv[1] $__command_not_found_confirmed_commands
              set -ga __fish_run_with_comma_commands $argv[1]
            end

            comma -- $argv
            return 0
          else
            __fish_default_command_not_found_handler $argv
          end
        '';
      };

      plugins = [
        {
          name = "fzf-fish";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
      ];
    };
  };
}
