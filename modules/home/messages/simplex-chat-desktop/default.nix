{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.messages.simplex-chat-desktop;
in
{
  options.${namespace}.messages.simplex-chat-desktop = {
    enable = mkBoolOpt false "Enable simplex-chat-desktop.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ simplex-chat-desktop ];
  };
}
