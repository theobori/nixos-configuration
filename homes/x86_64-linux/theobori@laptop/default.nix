{ pkgs, ... }:
{
  theobori-org.user = {
    enable = true;
    name = "theobori";
  };

  home.stateVersion = "24.11";
}
