{ config, lib, ... }:
let
  cfg = config.cli.programs.thefuck;
in
{
  options.cli.programs.thefuck = {
    enable = lib.mkEnableOption "Whether or not to enable thefuck";
  };

  config = lib.mkIf cfg.enable {
    programs.thefuck = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
