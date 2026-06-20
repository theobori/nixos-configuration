{
  pkgs,
  modulesPath,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) disabled enabled;
  inherit (lib) mkForce;
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
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        # no need to set devices, disko will add all devices that have a EF02 partition to the list already
        # devices = [ ];
        efiSupport = true;
        useOSProber = true;
        extraEntries = ''
          menuentry "UEFI Firmware Settings" {
            fwsetup
          }
        '';
      };
    };

    supportedFilesystems = [ "ntfs" ];
  };

  # See https://dataswamp.org/~solene/2022-01-13-nixos-hardened.html
  # disable coredump that could be exploited later
  # and also slow down the system when something crash
  systemd.coredump.enable = false;

  ${namespace} = rec {
    # See https://github.com/NixOS/nixpkgs/issues/525573
    #
    # It makes the QEMU dnsmasq server crash, it means my VMs cannot received DHCP responses
    networking.stevenBlackHosts = mkForce disabled;

    boot.plymouth = enabled;
    security.sudo = enabled;
    security.doas = enabled;

    hardware = {
      corsair = disabled; # Not using my CORSAIR keyboard anymore.
      razer = enabled;
    };

    desktops = {
      plasma6 = enabled;
      # gnome = enabled;
    };

    display-managers = {
      sddm = enabled;
      # gdm = enabled;
    };

    services = {
      virtualisation = {
        kvm = enabled;
        docker = enabled;
        flatpak = enabled;
      };
      xremap = enabled;
      excalidraw = enabled;
    };

    user.users = {
      theobori = {
        extraGroups = lib.optional hardware.razer.enable "openrazer";
      };
    };

    roles = {
      desktop = enabled;
      gaming = disabled; # disabled for the moment
    };
  };

  programs.fuse.userAllowOther = true;

  system.stateVersion = "26.05";
}
