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

  cfg = config.${namespace}.editors.gnome-builder;
in
{
  options.${namespace}.editors.gnome-builder = {
    enable = mkBoolOpt false "Whether or not to enable gnome-builder.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ gnome-builder ]; };
}
