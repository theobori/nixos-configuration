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

  cfg = config.${namespace}.cli.programs.openssl;
in
{
  options.${namespace}.cli.programs.openssl = {
    enable = mkBoolOpt false "Whether or not to enable openssl.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ openssl ]; };
}
