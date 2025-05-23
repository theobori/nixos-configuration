{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  theobori-nix = {
    roles = {
      social = enabled;
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

    services = {
      sops = {
        enable = true;
        defaultSopsFile = lib.snowfall.fs.get-file "secrets/vm/theobori/secrets.yaml";
      };
    };

    #desktops.addons.gnome = enabled;
    desktops.addons.plasma6 = enabled;
  };

  home.stateVersion = "25.05";
}
