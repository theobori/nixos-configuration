{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mapAttrs;
  inherit (lib.${namespace}) mkOpt enabled;

  cfg = config.${namespace}.user;

  userModule = types.submodule {
    options = with types; {
      extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
      extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
      initialPassword = mkOpt str "1" "The initial password to use when the user is first created.";
      shell = mkOpt package pkgs.fish "Default shell package";
    };
  };
in
{
  options.${namespace}.user = with types; {
    users = mkOpt (attrsOf userModule) { } "Attributes set representing every user on the system.";
  };

  config = {
    programs.fish = enabled;

    users.users = mapAttrs (
      name: user:
      {
        inherit name;
        inherit (user) initialPassword shell;

        isNormalUser = true;
        home = "/home/${name}";
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
          "nix"
          "power"
          "docker"
        ] ++ user.extraGroups;
      }
      // user.extraOptions
    ) cfg.users;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
