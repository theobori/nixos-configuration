{ pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;

  nix.enable = true;
  services = {
    openssh.enable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  system = {
    locale.enable = true;
  };

  user = {
    name = "nixos";
    initialPassword = "1";
  };

  system.stateVersion = "24.11";
}
