{ config, lib, ... }:
let
  cfg = config.cli.programs.lazygit;
in
{
  options.cli.programs.lazygit = {
    enable = lib.mkEnableOption "Whether or not to enable lazygit";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
