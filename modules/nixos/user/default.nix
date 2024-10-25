{ config, lib, ... }:
let
  cfg = config.user;
in
{
  options.user = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "theobori";
      description = "The name of the user's account";
    };

    initialPassword = lib.mkOption {
      type = lib.types.str;
      default = "1";
      description = "The initial password to use";
    };

    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Groups for the user to be assigned";
    };

    extraOptions = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Extra options passed to users.users.<name>";
    };
  };

  config = {
    users.mutableUsers = false;
    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";

      extraGroups = [
        "wheel"
        "audio"
        "sound"
        "video"
        "networkmanager"
        "input"
        "tty"
        "kvm"
        "libvirtd"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
