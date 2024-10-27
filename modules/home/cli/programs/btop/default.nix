{ lib, config, ... }:
let
  cfg = config.cli.programs.btop;
in
{
  options.cli.programs.btop = {
    enable = lib.mkEnableOption "Whether or not to enable btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;

      extraConfig = ''
        proc_left = False
      '';
    };
  };
}
