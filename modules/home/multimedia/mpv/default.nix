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

  cfg = config.${namespace}.multimedia.mpv;
in
{
  options.${namespace}.multimedia.mpv = {
    enable = mkBoolOpt false "Whether or not to manage mpv.";
  };

  config = mkIf cfg.enable {
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
