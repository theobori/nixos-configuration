{
  pkgs,
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib)
    mkIf
    getExe
    map
    optionals
    fold
    ;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (lib.strings) concatMapStrings;
  cfg = config.${namespace}.cli.shells.fish;

  mkPokemon =
    {
      name,
      forms ? [ "regular" ],
      shiny ? true,
    }:
    let
      p = map (form: "${getExe pkgs.krabby} name ${name} --no-title --form ${form}") forms;
      s = map (command: command + " --shiny") p;
    in
    p ++ (optionals shiny s);

  mkPokemons = pokemons: fold (el: c: c ++ (mkPokemon el)) [ ] pokemons;

  pokemonCommands = mkPokemons [
    {
      name = "gengar";
      forms = [
        "regular"
        "gmax"
      ];
    }
    {
      name = "mewtwo";
      shiny = false;
    }
    { name = "haunter"; }
    { name = "cloyster"; }
    { name = "gastly"; }
  ];
in
{
  options.${namespace}.cli.shells.fish = {
    enable = mkBoolOpt false "Enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        ${getExe pkgs.nix-your-shell} --nom fish | source

        set -gx GOPATH $XDG_DATA_HOME/go
        set -gx PATH /usr/local/bin /usr/bin ~/.local/bin $GOPATH/bin/ $PATH $HOME/.cargo/bin

        set -gx fzf_diff_highlighter delta --paging=never --line-numbers

        # \c = control, \e = escape
        bind --mode default \e\cn ${getExe pkgs.nsearch}
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
        v = "vkquake -window -width 1920 -height 1080";
      };

      functions = {
        fish_greeting = ''
          # Randomize the pokemon command
          set pokemond_commands ${concatMapStrings (command: "\"${command}\" ") pokemonCommands}
          set pokemon_index (random 1 (count $pokemond_commands))
          set pokemon_command $pokemond_commands[$pokemon_index]

          eval $pokemon_command
        '';

        fish_command_not_found = ''
          # If you run the command with comma, running the same command
          # will not prompt for confirmation for the rest of the session
          if contains $argv[1] $__command_not_found_confirmed_commands
            or ${getExe pkgs.gum} confirm --selected.background=2 "Run using comma?"

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
        {
          name = "bang-bang";
          inherit (pkgs.fishPlugins.bang-bang) src;
        }
        {
          name = "spark";
          inherit (pkgs.fishPlugins.spark) src;
        }
        {
          name = "sponge";
          inherit (pkgs.fishPlugins.sponge) src;
        }
      ];
    };
  };
}
