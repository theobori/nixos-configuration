{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  xmodmapExe = lib.getExe pkgs.xorg.xmodmap;

  cfg = config.${namespace}.display-managers.x-utility;
in
{
  options.${namespace}.display-managers.x-utility = with types; {
    enable = mkBoolOpt false "Enable x-utility.";
    sessionCommands = mkOpt str ''
      ${xmodmapExe} -e "clear lock" -e "keycode 66 = Control_L" -e "add Control = Control_L"
    '' "Manage the X session command";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager = {
      inherit (cfg) sessionCommands;
    };
  };
}
