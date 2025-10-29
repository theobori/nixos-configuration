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

  cfg = config.${namespace}.programs.bitwarden;
in
{
  options.${namespace}.programs.bitwarden = {
    enable = mkBoolOpt false "Whether or not to manage bitwarden.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ bitwarden-desktop ]; };
}
