{ pkgs, ... }:
{
  theobori-org.user = {
    enable = true;
    name = "theobori";
  };

  roles = {
    social.enable = true;
    desktop.enable = true;
    games.enable = true;
  };

  home.stateVersion = "24.11";
}
