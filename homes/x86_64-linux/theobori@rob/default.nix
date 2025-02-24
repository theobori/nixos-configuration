{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled disabled;
in
{
  theobori-nix = {
    roles = {
      desktop = enabled;
      gaming = enabled;
    };

    user = {
      enable = true;
      name = "theobori";
    };

    cli.programs = {
      ssh.useSops = true;
      gpg.useSops = true;
    };

    messages = {
      discord = enabled;
      ayugram = enabled;
    };

    services = {
      sops = {
        enable = true;
        defaultSopsFile = lib.snowfall.fs.get-file "secrets/rob/theobori/secrets.yaml";
      };
      flatpak = disabled;
    };

    desktops = {
      addons = {
        plasma6 = enabled;
      };
    };

    editors.emacs.packages = {
      markdown = enabled;
      yaml = enabled;
      org-present = enabled;
      ivy = enabled;
      dashboard = enabled;
      rg = enabled;
      vertico = enabled;
      rainbow-delimiters = enabled;
      doom-modeline = enabled;
      vterm = enabled;
      org-superstar = enabled;
      dired = enabled;
      auto-save = enabled;
      org-download = enabled;
      treemacs = enabled;
      lsp-mode = {
        enable = true;
        pylsp = enabled;
        bash-language-server = enabled;
        nixd = enabled;
        gopls = enabled;
        dockerfile = enabled;
        terraform = enabled;
      };
    };
  };

  home.stateVersion = "24.11";
}
