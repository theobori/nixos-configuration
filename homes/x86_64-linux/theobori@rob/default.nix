{
  inputs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled disabled;
in
{
  theobori-nix = {
    accounts = {
      email = enabled;
    };

    roles = {
      desktop = enabled;
      gaming = enabled;
      social = enabled;
    };

    user = {
      enable = true;
      name = "theobori";
    };

    cli.programs = {
      ssh.useSops = true;
      gpg.useSops = true;
    };

    services = {
      sops = {
        enable = true;
        defaultSopsFile = "${inputs.my-secrets}/secrets/rob/theobori/secrets.yaml";
      };
      flatpak = disabled;
    };

    desktops = {
      addons = {
        plasma6 = enabled;
        # gnome = enabled;
      };
    };

    editors.emacs.packages = {
      markdown = enabled;
      yaml = enabled;
      magit = enabled;
      pdf-tools = enabled;
      org-present = enabled;
      ivy = disabled;
      dashboard = enabled;
      rg = enabled;
      vertico = enabled;
      consult = enabled;
      orderless = enabled;
      rainbow-delimiters = enabled;
      doom-modeline = enabled;
      vterm = enabled;
      org-superstar = enabled;
      dired = enabled;
      auto-save = enabled;
      org-download = enabled;
      org = enabled;
      org-journal = enabled;
      treemacs = enabled;
      ligature = enabled;
      lsp-mode = {
        enable = true;
        pylsp = enabled;
        bash-language-server = enabled;
        nixd = enabled;
        gopls = enabled;
        dockerfile = enabled;
        terraform = enabled;
        latex = enabled;
        typescript = enabled;
      };
      all-the-icons-ibuffer = enabled;
      direnv = enabled;
      notmuch = enabled;
    };
  };

  home.stateVersion = "25.11";
}
