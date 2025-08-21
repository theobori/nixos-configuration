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

  cfg = config.${namespace}.system.uutils-coreutils;
in
{
  options.${namespace}.system.uutils-coreutils = {
    enable = mkBoolOpt false "Whether or not to manage uutils-coreutils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ (lib.hiPrio uutils-coreutils-noprefix) ];
  };
}
