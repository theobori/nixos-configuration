{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.browsers.librewolf;
in
{
  options.browsers.librewolf = {
    enable = lib.mkEnableOption "Enable librewolf browser";
  };

  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
