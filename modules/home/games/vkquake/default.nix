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

  cfg = config.${namespace}.games.vkquake;
in
{
  options.${namespace}.games.vkquake = {
    enable = mkBoolOpt false "Enable vkquake.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ vkquake ]; };
}
