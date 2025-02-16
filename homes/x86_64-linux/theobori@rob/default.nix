{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
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
    };

    desktops.addons.plasma6 = enabled;

    editors.emacs.packages = {
      neotree = enabled;
      ivy = enabled;
      vertico = enabled;
      lsp-mode = {
        enable = true;
        pylsp = enabled;
        bash-language-server = enabled;
        nixd = enabled;
        gopls = enabled;
      };
    };
  };

  home.stateVersion = "24.11";
}
