{ pkgs, ... }:
{
  theobori-org.user = {
    enable = true;
    name = "theobori";
  };

  # tmp just for testing purposes
  home.packages = with pkgs; [ git ];

  home.stateVersion = "23.11";
}
