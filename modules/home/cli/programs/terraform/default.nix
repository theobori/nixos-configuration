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

  cfg = config.${namespace}.cli.programs.terraform;
in
{
  options.${namespace}.cli.programs.terraform = {
    enable = mkBoolOpt false "Whether or not to enable Terraform.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ terraform ]; };
}
