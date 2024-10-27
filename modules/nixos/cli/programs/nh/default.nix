{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.cli.programs.nh;
in
{
  options.cli.programs.nh = {
    enable = lib.mkEnableOption "Whether or not to enable nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.user.name}/${namespace}";
    };
  };
}
