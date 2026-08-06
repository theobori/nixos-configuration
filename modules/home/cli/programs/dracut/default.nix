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

  cfg = config.${namespace}.cli.programs.dracut;
in
{
  options.${namespace}.cli.programs.dracut = {
    enable = mkBoolOpt false "Whether or not to manage Dracut.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      dracut
    ];
  };
}
