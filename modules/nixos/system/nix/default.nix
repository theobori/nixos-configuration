{ config, lib, ... }:
let
  cfg = config.system.nix;
in
{
  options.system.nix = {
    enable = lib.mkEnableOption "Whether or not to manage nix configuration";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        trusted-users = [
          "@wheel"
          "root"
        ];
        auto-optimise-store = lib.mkDefault true;
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
        system-features = [
          "kvm"
          "big-parallel"
          "nixos-test"
        ];
        max-jobs = "auto";
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
