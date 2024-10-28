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

  cfg = config.${namespace}.programs.obsidian;
in
{
  options.${namespace}.programs.obsidian = {
    enable = mkBoolOpt false "Whether or not to manage obsidian.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ obsidian ]; };
}
