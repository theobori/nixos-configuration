{ pkgs, ... }:
{
  theobori-org.user = {
    enable = true;
    name = "theobori";
  };

  roles = {
    common.enable = true;
  };

  home.stateVersion = "24.11";
}
