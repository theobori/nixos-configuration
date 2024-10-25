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

  user = {
    name = "nixos";
    initialPassword = "1";
  };

  system.stateVersion = "23.11";
}
