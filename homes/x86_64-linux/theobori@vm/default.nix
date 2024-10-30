{ lib, ... }:
{
  theobori-nix = {
    roles = {
      social.enable = true;
      desktop.enable = true;
      gaming.enable = true;
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
        defaultSopsFile = lib.snowfall.fs.get-file "secrets/vm/theobori/secrets.yaml";
      };
    };
  };

  home.stateVersion = "24.11";
}
