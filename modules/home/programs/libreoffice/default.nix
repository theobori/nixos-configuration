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

  cfg = config.${namespace}.programs.libreoffice;
in
{
  options.${namespace}.programs.libreoffice = {
    enable = mkBoolOpt false "Whether or not to manage libreoffice.";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ libreoffice ]; };
}
