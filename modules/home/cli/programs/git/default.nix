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

    signByDefault = mkOpt types.bool true "Whether to sign commits by default.";
    signingKey =
      mkOpt types.str "${config.home.homeDirectory}/.ssh/id_ed25519"
        "The key ID to sign commits with.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
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

      extraConfig = {
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        commit.gpgsign = true;
        #user.signingkey = "~/.ssh/id_ed25519.pub";

        core = {
          editor = "emacs";
          pager = "delta";
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
  };
}
