{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt enabled;
  inherit (config.${namespace}) user;

  cfg = config.${namespace}.cli.programs.git;
in
{
  options.${namespace}.cli.programs.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";

    signByDefault = mkOpt bool true "Whether to sign commits by default.";
    signingKey =
      mkOpt str "EEFBCC3AC529CFD1943DA75CBDD57BE99D555965"
        "The GnuPG signing key fingerprint sign commits with.";
    userName = mkOpt str user.fullName "The name to configure git with.";
    userEmail = mkOpt str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    ${namespace}.editors.emacs = enabled;

    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      inherit (cfg) userName userEmail;

      signing = {
        key = cfg.signingKey;
        inherit (cfg) signByDefault;
      };

      aliases = {
        dlc = "diff --cached HEAD^";
        incoming = "log HEAD..@{upstream}";
        outgoing = "log @{upstream}..HEAD";
        cam = "commit --amend";
        graph = "log --graph -10 --branches --remotes --tags  --format=format:'%Cgreen%h %Creset• %<(75,trunc)%s (%cN, %cr) %Cred%d' --date-order";
        stashes = "stash list";
      };

      extraConfig = {
        commit.gpgsign = true;

        core = {
          editor = "emacs";
          pager = "delta";
          filemode = "false";
        };

        color = {
          ui = true;
        };

        fetch = {
          prune = true;
        };

        interactive = {
          diffFitler = "delta --color-only";
        };

        delta = {
          enable = true;
          navigate = true;
          light = false;
          side-by-side = false;
          line-numbers = true;
          options.syntax-theme = "dracula";
        };

        pull = {
          ff = "only";
        };

        push = {
          default = "current";
          autoSetupRemote = true;
        };

        safe = {
          directory = [
            "~/${namespace}/"
            "/etc/nixos"
          ];
        };

        init = {
          defaultBranch = "main";
        };
      };
    };

    home.packages = with pkgs; [ gitmoji-cli ];
  };
}
