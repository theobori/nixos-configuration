{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.multimedia.mpv;
in
{
  options.multimedia.mpv = {
    enable = lib.mkEnableOption "Whether or not to manage mpv";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        visualizer
        thumbfast
        modernx
      ];
    };
  };
}
