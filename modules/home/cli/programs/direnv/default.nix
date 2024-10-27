{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.direnv;
in
{
  options.cli.programs.direnv = {
    enable = lib.mkEnableOption "Whether or not to enable direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
