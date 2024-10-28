{ pkgs, namespace, ... }:
{
  theobori-nix = {
    roles = {
      social.enable = true;
      desktop.enable = true;
      games.enable = true;
    };

    user = {
      enable = true;
      name = "theobori";
    };
  };

  home.stateVersion = "24.11";
}
