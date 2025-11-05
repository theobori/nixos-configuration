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

  cfg = config.${namespace}.messages.deltachat;
in
{
  options.${namespace}.messages.deltachat = {
    enable = mkBoolOpt false "Enable deltachat.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ deltachat-desktop ];
  };
}
