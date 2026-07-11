{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.lorri;
in
{
  options.${namespace}.services.lorri = with types; {
    enable = mkBoolOpt false "Whether to enable lorri.";
    nixPackage = mkOpt package pkgs.nix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    services.lorri = {
      enable = true;
      inherit (cfg) nixPackage;
    };
  };
}
