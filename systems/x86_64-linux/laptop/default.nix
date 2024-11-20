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
    };
    supportedFilesystems = [ "ntfs" ];

    kernel.sysctl = {
      #Do less swapping
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 60;
      "vm.dirty_background_ratio" = 2;

      # Number of times SYNACKs for passive TCP connection.
      "net.ipv4.tcp_synack_retries" = 2;

      # Allowed local port range
      "net.ipv4.ip_local_port_range" = "2000 65535";

      # Protect Against TCP Time-Wait
      "net.ipv4.tcp_rfc1337" = 1;

      # Decrease the time default value for tcp_fin_timeout connection
      "net.ipv4.tcp_fin_timeout" = 15;

      # Decrease the time default value for connections to keep alive
      "net.ipv4.tcp_keepalive_time" = 300;
      "net.ipv4.tcp_keepalive_probes" = 5;
      "net.ipv4.tcp_keepalive_intvl" = 15;

      ### TUNING NETWORK PERFORMANCE ###

      # Default Socket Receive Buffer
      "net.core.rmem_default" = 31457280;

      # Maximum Socket Receive Buffer
      "net.core.rmem_max" = 12582912;

      # Default Socket Send Buffer
      "net.core.wmem_default" = 31457280;

      # Maximum Socket Send Buffer
      "net.core.wmem_max" = 12582912;

      # Increase number of incoming connections
      "net.core.somaxconn" = 4096;

      # Increase number of incoming connections backlog
      "net.core.netdev_max_backlog" = 65536;

      # Increase the maximum amount of option memory buffers
      "net.core.optmem_max" = 25165824;

      # Increase the maximum total buffer-space allocatable
      # This is measured in units of pages (4096 bytes)
      "net.ipv4.tcp_mem" = "65536 131072 262144";
      "net.ipv4.udp_mem" = "65536 131072 262144";

      # Increase the read-buffer space allocatable
      "net.ipv4.tcp_rmem" = "8192 87380 16777216";
      "net.ipv4.udp_rmem_min" = 16384;

      # Increase the write-buffer-space allocatable
      "net.ipv4.tcp_wmem" = "8192 65536 16777216";
      "net.ipv4.udp_wmem_min" = 16384;
    };
  };

  ${namespace} = {
    boot.plymouth = enabled;
    security.doas = enabled;

    desktops.plasma6 = enabled;
    display-managers.sddm = enabled;

    services.virtualisation = {
      kvm = enabled;
      docker = enabled;
    };

    user.users = {
      theobori = { };
    };

    roles = {
      gaming = enabled;
      desktop = enabled;
    };
  };

  programs.fuse.userAllowOther = true;

  system.stateVersion = "24.11";
}
