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

  cfg = config.${namespace}.editors.code-cursor;
in
{
  options.${namespace}.editors.code-cursor = {
    enable = mkBoolOpt false "Whether or not to enable code-cursor.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ code-cursor ]; };
}
