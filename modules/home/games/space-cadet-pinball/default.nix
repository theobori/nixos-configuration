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

  cfg = config.${namespace}.games.space-cadet-pinball;
in
{
  options.${namespace}.games.space-cadet-pinball = {
    enable = mkBoolOpt false "Enable space-cadet-pinball.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ space-cadet-pinball ]; };
}
