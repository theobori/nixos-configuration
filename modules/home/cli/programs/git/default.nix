{ config, lib, ... }:
let
  cfg = config.cli.programs.git;

  rewriteURL =
    urlRewrites:
    lib.mapAttrs' (key: value: {
      name = "url.${key}";
      value = {
        insteadOf = value;
      };
    }) urlRewrites;
in
{
  options.cli.programs.git = {
    enable = lib.mkEnableOption "Whether or not to enable git";

    name = lib.mkOption {
      type = lib.types.str;
      default = "Théo Bori";
      description = "The name to use with git";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "theo1.bori@epitech.eu";
      description = "The email to use with git";
    };

    urlRewrites = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "URL we need to rewrite i.e. SSH to HTTP";
    };

    allowedSigners = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The public key used for signing commits";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file.".ssh/allowed_signers".text = "* ${cfg.allowedSigners}";

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;

      extraConfig = {
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        commit.gpgsign = true;
        user.signingkey = "~/.ssh/id_ed25519.pub";

        core = {
          editor = "emacs -nw";
          pager = "delta";
        };

        color = {
          ui = true;
        };

        interactive = {
          diffFitler = "delta --color-only";
        };

        delta = {
          enable = true;
          navigate = true;
          light = false;
          side-by-side = false;
          options.syntax-theme = "dracula";
        };

        pull = {
          ff = "only";
        };

        push = {
          default = "current";
          autoSetupRemote = true;
        };

        init = {
          defaultBranch = "init";
        };
      } // (rewriteURL cfg.urlRewrites);
    };
  };
}
