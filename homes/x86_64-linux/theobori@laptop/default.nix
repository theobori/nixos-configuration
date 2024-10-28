{ pkgs, namespace, ... }:
{
  theobori-nix.user = {
    enable = true;
    name = "theobori";
  };

  home.stateVersion = "24.11";
}
