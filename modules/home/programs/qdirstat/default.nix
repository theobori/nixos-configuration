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

  cfg = config.${namespace}.programs.cambalache;
in
{
  options.${namespace}.programs.cambalache = {
    enable = mkBoolOpt false "Whether or not to manage cambalache.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ cambalache ]; };
}
