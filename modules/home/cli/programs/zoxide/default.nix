{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.zoxide;
in
{
  options.cli.programs.zoxide = {
    enable = lib.mkEnableOption "Whether or not to enable zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
