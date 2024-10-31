{
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  boot.loader.systemd-boot = enabled;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager = enabled;

  nix = enabled;
  services = {
    openssh = enabled;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  ${namespace} = {
    system = {
      locale = enabled;
    };

    user = {
      name = "nixos";
      initialPassword = "1";
    };
  };

  system.stateVersion = "24.11";
}
