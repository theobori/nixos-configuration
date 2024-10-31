{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.${namespace}) mkOpt enabled;

  cfg = config.${namespace}.user;
in
{
  options.${namespace}.user = with types; {
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
    initialPassword = mkOpt str "1" "The initial password to use when the user is first created.";
    name = mkOpt str "theobori" "The name to use for the user account.";
  };

  config = {
    programs.fish = enabled;

    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;
      uid = 1000;

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
        "nix"
        "power"
        "docker"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
