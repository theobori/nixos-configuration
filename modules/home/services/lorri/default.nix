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

  cfg = config.${namespace}.services.lorri;
in
{
  options.${namespace}.services.lorri = {
    enable = mkBoolOpt false "Whether to enable lorri.";
  };

  config = mkIf cfg.enable {
    services.lorri = {
      enable = true;
      nixPackage = pkgs.lix;
    };
  };
}
