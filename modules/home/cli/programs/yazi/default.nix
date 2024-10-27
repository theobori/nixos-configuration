{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.yazi;
in
{
  options.cli.programs.yazi = {
    enable = lib.mkEnableOption "Whether or not to enable yazi";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      imagemagick
      ffmpegthumbnailer
      fontpreview
      unar
      poppler
      unar
    ];
  };
}
