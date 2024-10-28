{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.roles.social;
in
{
  options.roles.social = {
    enable = lib.mkEnableOption "Enable social suite";
  };

  config = lib.mkIf cfg.enable {
    messages = {
      discord.enable = true;
      thunderbird.enable = true;
    };
  };
}
