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

  cfg = config.${namespace}.browsers.tor-browser;
in
{
  options.${namespace}.browsers.tor-browser = {
    enable = mkBoolOpt false "Whether or not to manage Tor browser.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ tor-browser ]; };
}
