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

  cfg = config.${namespace}.programs.sqlitebrowser;
in
{
  options.${namespace}.programs.sqlitebrowser = {
    enable = mkBoolOpt false "Whether or not to manage sqlitebrowser.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ sqlitebrowser ]; };
}
