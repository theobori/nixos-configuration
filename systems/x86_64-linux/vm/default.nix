{
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

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services = {
    openssh = enabled;
  };

  ${namespace} = {

    security = {
      doas = enabled;
      sops = {
        enable = true;
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };
    };

    desktops = {
      plasma6 = enabled;
    };
    display-managers.sddm = enabled;

    roles.desktop = enabled;
    services.virtualisation.kvm = enabled;
  };

  programs.fuse.userAllowOther = true;

  system.stateVersion = "24.11";
}
