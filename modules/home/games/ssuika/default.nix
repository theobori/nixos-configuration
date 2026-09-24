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

  cfg = config.${namespace}.games.ssuika;
in
{
  options.${namespace}.games.ssuika = {
    enable = mkBoolOpt false "Enable ssuika.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs.${namespace}; [ ssuika ]; };
}
