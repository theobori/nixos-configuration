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

  cfg = config.${namespace}.cli.programs.dua;
in
{
  options.${namespace}.cli.programs.dua = {
    enable = mkBoolOpt false "Whether or not to enable dua.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ dua ]; };
}
