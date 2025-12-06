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

  cfg = config.${namespace}.messages.dino;
in
{
  options.${namespace}.messages.dino = {
    enable = mkBoolOpt false "Enable dino.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dino ];
  };
}
