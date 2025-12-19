{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.virtualisation.kvm;
in
{
  options.${namespace}.services.virtualisation.kvm = {
    enable = mkBoolOpt false "Enable kvm virtualisation.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libguestfs
      virtio-win
      win-spice
      virt-manager
      virt-viewer
    ];

    virtualisation = {
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        allowedBridges = [
          "nm-bridge"
          "virbr0"
        ];
        onBoot = "ignore";
        onShutdown = "shutdown";
        qemu = {
          swtpm.enable = true;
        };
      };
    };
  };
}
