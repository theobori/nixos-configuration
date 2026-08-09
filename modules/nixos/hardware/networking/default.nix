{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = {
    enable = mkBoolOpt false "Enable networkmanager.";
  };

  config = mkIf cfg.enable {
    # As describe at https://wiki.archlinux.org/title/Stubby,
    # Stubby implement DNS over TLS butdoes not have a built-in DNS cache.
    #
    # So my goal is to use dnsmasq as DNS proxy that has a local DNS cache.
    #
    # dnsmasq will listen on port 53 and then it will transmit
    # the DNS request to Stubby at port 54.
    services.stubby = {
      enable = true;
      settings = pkgs.stubby.passthru.settingsExample // {
        listen_addresses = [
          "127.0.0.1@54"
          "0::1@54"
        ];

        upstream_recursive_servers = [
          {
            address_data = "116.202.176.26";
            tls_auth_name = "dot.libredns.gr";
            tls_pubkey_pinset = [
              {
                digest = "sha256";
                value = "V0Y0pvWkAwOPkNSPxDyZd/vJ2bo40ylADWJFu/ubPlM=";
              }
            ];
          }
        ];
      };
    };

    services.dnsmasq = {
      enable = true;
      settings = {
        no-resolv = true;
        proxy-dnssec = true;
        # This parameter force stubby to bind the port 53 to the lo network interface only.
        # Otherwise, it can conflict with the libvirt dnsmasq instance on the virbr0 network interface.
        bind-interfaces = true;
        server = [
          "127.0.0.1#54"
          "::1#54"
        ];
        listen-address = "127.0.0.1";
        interface = "lo";
      };
    };

    networking = {
      # Since I want to use DNS over TLS only, the block
      # below must not change. It must points to the local dnsmasq service
      # declared below.
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      # It prevents /etc/resolv.conf being overwritten
      dhcpcd.extraConfig = "nohook resolv.conf";
      networkmanager = {
        enable = true;
        # It prevents /etc/resolv.conf being overwritten
        dns = "none";
      };

      firewall = {
        enable = true;
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
      };
    };
  };
}
