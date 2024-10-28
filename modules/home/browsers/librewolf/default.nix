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

  cfg = config.${namespace}.browsers.librewolf;
in
{
  options.${namespace}.browsers.librewolf = {
    enable = mkBoolOpt false "Enable librewolf browser.";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
