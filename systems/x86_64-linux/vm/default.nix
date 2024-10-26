{
  modulesPath,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  services = {
    openssh.enable = true;
  };

  security = {
    theobori-org = {
      doas.enable = true;
    };
  };

  desktops = {
    plasma6.enable = true;
  };

  roles.common.enable = true;

  programs.fuse.userAllowOther = true;


  system.stateVersion = "24.11";
}
