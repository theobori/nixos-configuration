{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.wine;
in
{
  options.${namespace}.programs.wine = {
    enable = mkBoolOpt false "Whether or not to enable support for wine.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable # 32-bit and 64-bit applications support
    ];
  };
}
