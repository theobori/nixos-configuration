{ config, lib, ... }:
let
  cfg = config.cli.programs.fzf;
in
{
  options.cli.programs.fzf = {
    enable = lib.mkEnableOption "Whether or not to enable fzf";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = false;
      colors =
        with config.lib.stylix.colors.withHashtag;
        lib.mkForce {
          "bg" = base00;
          "bg+" = base02;
          "fg" = base05;
          "fg+" = base05;
          "header" = base0E;
          "hl" = base08;
          "hl+" = base08;
          "info" = base0A;
          "marker" = base06;
          "pointer" = base06;
          "prompt" = base0E;
          "spinner" = base06;
        };
    };
  };
}
