{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  xmodmapExe = lib.getExe pkgs.xorg.xmodmap;

  cfg = config.${namespace}.display-managers.x-utility;
in
{
  options.${namespace}.display-managers.x-utility = {
    enable = mkBoolOpt false "Enable x-utility.";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager = {
      sessionCommands = ''
        ${xmodmapExe} -e "clear lock" -e "keycode 66 = Control_L" -e "add Control = Control_L"
      '';
    };
  };
}
