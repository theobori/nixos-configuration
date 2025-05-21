{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  theobori-nix = {
    roles = {
      desktop = enabled;
    };

    user = {
      enable = true;
      name = "nagi";
    };

    desktops.addons.plasma6 = enabled;
  };

  home.stateVersion = "25.05";
}
