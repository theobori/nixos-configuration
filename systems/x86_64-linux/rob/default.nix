{
  pkgs,
  modulesPath,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub = {
      # no need to set devices, disko will add all devices that have a EF02 partition to the list already
      # devices = [ ];
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
    };
    supportedFilesystems = [ "ntfs" ];

  };

  ${namespace} = {
    boot.plymouth = enabled;
    security.sudo = enabled;
    security.doas = enabled;

    desktops = {
      plasma6 = enabled;
    };
    display-managers = {
      sddm = enabled;
      x-utility = enabled;
    };

    services.virtualisation = {
      kvm = enabled;
      docker = enabled;
      flatpak = enabled;
    };

    user.users = {
      theobori = { };
    };

    roles = {
      desktop = enabled;
    };
  };

  programs.fuse.userAllowOther = true;

  system.stateVersion = "25.05";
}
