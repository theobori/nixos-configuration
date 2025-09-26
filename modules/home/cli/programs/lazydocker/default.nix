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

  cfg = config.${namespace}.cli.programs.lazydocker;
in
{
  options.${namespace}.cli.programs.lazydocker = {
    enable = mkBoolOpt false "Whether or not to enable lazydocker.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ lazydocker ]; };
}
