{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.browsers.librewolf;
in
{
  options.${namespace}.browsers.librewolf = {
    enable = mkBoolOpt false "Enable librewolf browser.";
  };

  config = mkIf cfg.enable {
    stylix.targets.librewolf.profileNames = [ config.${namespace}.user.name ];
    programs.librewolf = {
      enable = true;
    };
  };
}
