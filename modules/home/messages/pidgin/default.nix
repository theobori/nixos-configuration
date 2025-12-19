{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.messages.pidgin;
in
{
  options.${namespace}.messages.pidgin = {
    enable = mkBoolOpt false "Whether or not to manage pidgin.";
  };

  config = mkIf cfg.enable {
    programs.pidgin = {
      enable = true;

      plugins = with pkgs.pidginPackages; [
        pidgin-otr
        pidgin-osd
        pidgin-indicator
      ];
    };
  };
}
