{ lib, namespace, ... }:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    ./disk-config.nix
    # ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  ${namespace} = {
    security = {
      doas = enabled;
      sops = {
        enable = true;
      };
    };

    desktops = {
      plasma6 = enabled;
    };
    display-managers.sddm = enabled;

    roles.desktop = enabled;
    services.virtualisation = {
      kvm = enabled;
      docker = enabled;
    };
  };

  system.stateVersion = "24.11";
}
