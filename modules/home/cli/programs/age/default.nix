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

  cfg = config.${namespace}.cli.programs.age;
in
{
  options.${namespace}.cli.programs.age = {
    enable = mkBoolOpt false "Whether or not to enable age.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ age ]; };
}
